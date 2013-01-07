#!/usr/bin/env ruby

# This is free software released into the public domain (CC0 license).

require 'prawn'
require "prawn/measurement_extensions"

pdf_opts = {
	:page_size => 'A4',
	:margin => 0
}

paper_sizes = {
	'A4' => [210, 297],
	'A5' => [148, 210],
	'A6' => [105, 148],

	'B5' => [176, 250],
	'B6' => [125, 176],

	'C5' => [162, 229],
	'C6' => [114, 162],
}


def arrow_line(pdf)
	bb = pdf.bounds

	v_center = pdf.cursor + 0.8.mm

	measurements_box_width = 18.mm

	line_length = bb.right - bb.left
	line_left_end    = (line_length / 2) - (measurements_box_width / 2)
	line_right_begin = (line_length / 2) + (measurements_box_width / 2)

	#---
	pdf.stroke_line [bb.left, v_center],
	                [line_left_end, v_center]

	pdf.stroke_line [line_right_begin, v_center],
	                [bb.right, v_center]

	h_offset = 0.35.mm
	w_offset = 1.mm

	#/--
	pdf.stroke_line [bb.left, v_center],
	                [bb.left + w_offset.mm, v_center + h_offset.mm]

	#\--
	pdf.stroke_line [bb.left, v_center],
	                [bb.left + w_offset.mm, v_center - h_offset.mm]

	#--\
	pdf.stroke_line [bb.right, v_center],
	                [bb.right - w_offset.mm, v_center + h_offset.mm]

	#--/
	pdf.stroke_line [bb.right, v_center],
	                [bb.right - w_offset.mm, v_center - h_offset.mm]
end

def measurement_box(name, width, pdf)
		pdf.move_up 2.mm
		pdf.text "#{width}mm (#{name})", :align => :center, :size => 8
end

pdf = Prawn::Document.new(pdf_opts)

paper_sizes.to_a.sort.each { |name, size|
	width, height = *size

	format = name[0..0]

	pdf.bounding_box [0, height.mm], :width => width.mm, :height => height.mm do
		case format
		when 'B'
			pdf.dash(10, :space => 2)
		when 'C'
			pdf.dash(2, :space => 2)
		else
			pdf.undash
		end
		pdf.undash # FIXME: hack, otherwise dashing acts in strange way

		pdf.stroke_bounds

		pdf.pad(1.mm) do
			pdf.text name, :align => :right
		end

		pdf.undash

		arrow_line(pdf)
		measurement_box(name, width, pdf)
	end
}

pdf.render_file "papersize.pdf"
