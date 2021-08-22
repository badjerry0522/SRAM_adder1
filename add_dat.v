module add_dat (
    input clk,
    input [31:0] data,
    output [31:0] S_out
);

    reg [31:0]reg_data,S;
    wire [31:0]S1;
    assign S1=S+data;
    assign S_out=S;

    always @(posedge clk) begin
        reg_data<=data;
        S<=S1;
    end
    
endmodule