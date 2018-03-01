module muldivlen (
	input clock
);
	// MulDiv inputs
	(* keep *) rand       reg        io_req_valid;
	(* keep *) rand const reg [ 3:0] io_req_bits_fn;
	(* keep *) rand const reg [31:0] io_req_bits_in1;
	(* keep *) rand const reg [31:0] io_req_bits_in2;
	(* keep *) rand       reg [ 4:0] io_req_bits_tag;
	(* keep *) rand       reg        io_kill;
	(* keep *) wire                  io_resp_ready;

	// MulDiv outputs
	(* keep *) wire        io_req_ready;
	(* keep *) wire        io_resp_valid;
	(* keep *) wire [31:0] io_resp_bits_data;
	(* keep *) wire [ 4:0] io_resp_bits_tag;

	reg reset = 1;
	always @(posedge clock) reset <= 0;

	integer i;
	integer job_len;

	assign io_resp_ready = (job_len != 0);

	wire values_ok =
			(io_req_bits_in1 == 32'h 0000_0000 || io_req_bits_in1 == 32'h ffff_ffff) &&
			(io_req_bits_in2 == 32'h 0000_0000 || io_req_bits_in2 == 32'h ffff_ffff);

	always @(posedge clock) begin
		if (reset) begin
			assume (!io_req_valid);
			job_len <= 0;
		end else begin
			job_len <= job_len + |job_len;
			if (io_resp_ready && io_resp_valid) begin
				case (io_req_bits_fn)
					0: begin
						cover (values_ok && job_len == 33);
						assert (job_len == 33);
					end
					1: begin
						cover (values_ok && job_len == 33);
						assert (job_len == 33);
					end
					2: begin
						cover (values_ok && job_len == 33);
						assert (job_len == 33);
					end
					3: begin
						cover (values_ok && job_len == 33);
						assert (job_len == 33);
					end
					4: begin
						cover (values_ok && job_len == 34);
						cover (values_ok && job_len == 35);
						cover (values_ok && job_len == 36);
						assert (34 <= job_len && job_len <= 36);
					end
					5: begin
						cover (values_ok && job_len == 34);
						assert (job_len == 34);
					end
					6: begin
						cover (values_ok && job_len == 34);
						cover (values_ok && job_len == 35);
						cover (values_ok && job_len == 36);
						assert (34 <= job_len && job_len <= 36);
					end
					7: begin
						cover (values_ok && job_len == 34);
						assert (job_len == 34);
					end
					8: begin
						cover (values_ok && job_len == 33);
						assert (job_len == 33);
					end
					9: begin
						cover (values_ok && job_len == 33);
						assert (job_len == 33);
					end
					10: begin
						cover (values_ok && job_len == 33);
						assert (job_len == 33);
					end
					11: begin
						cover (values_ok && job_len == 33);
						assert (job_len == 33);
					end
					12: begin
						cover (values_ok && job_len == 34);
						cover (values_ok && job_len == 35);
						cover (values_ok && job_len == 36);
						assert (34 <= job_len && job_len <= 36);
					end
					13: begin
						cover (values_ok && job_len == 34);
						assert (job_len == 34);
					end
					14: begin
						cover (values_ok && job_len == 34);
						cover (values_ok && job_len == 35);
						cover (values_ok && job_len == 36);
						assert (34 <= job_len && job_len <= 36);
					end
					15: begin
						cover (values_ok && job_len == 34);
						assert (job_len == 34);
					end
				endcase
				job_len <= 0;
			end
			if (io_req_ready && io_req_valid) begin
				assume (job_len == 0);
				job_len <= 1;
			end
		end
	end

	MulDiv uut (
		.clock             (clock            ),
		.reset             (reset            ),
		.io_req_ready      (io_req_ready     ),
		.io_req_valid      (io_req_valid     ),
		.io_req_bits_fn    (io_req_bits_fn   ),
		.io_req_bits_in1   (io_req_bits_in1  ),
		.io_req_bits_in2   (io_req_bits_in2  ),
		.io_req_bits_tag   (io_req_bits_tag  ),
		.io_kill           (io_kill          ),
		.io_resp_ready     (io_resp_ready    ),
		.io_resp_valid     (io_resp_valid    ),
		.io_resp_bits_data (io_resp_bits_data),
		.io_resp_bits_tag  (io_resp_bits_tag ),
	);
endmodule
