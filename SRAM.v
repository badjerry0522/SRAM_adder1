module SRAM (
    input clk,
    input we,
    input [8:0] addr,
    input [31:0] din,
    output [31:0] dout
);
    reg [31:0] mem[511:0];
    always @(posedge clk) begin
        if(we) mem[addr]<=din;
    end
    assign dout=mem[addr];
endmodule