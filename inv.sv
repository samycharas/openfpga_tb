package inv_pkg;
	bit IN;
	function bit inv(bit IN);
		inv = !IN;
	endfunction
endpackage : inv_pkg

/**
module inv (
	input IN,
	output OUT );

	assign OUT = !IN;

endmodule
**/
