module SRAM_adder (
    input clk,
    input sel,  input first,
    input addr_minus_en,

    input SRAM_we,  input SRAM_re,
    input [8:0] waddr,
    input [31:0] din,

    output busy,
    output [31:0] S
);
    wire [31:0] bridge;
    wire zero;
    

    get_dat gd1(
        .clk(clk),
        .first(first),  .sel(sel),
        .dout(bridge),
        .zero(zero),
        .SRAM_re(SRAM_re),  .SRAM_we(SRAM_WE),
        .addr_minus_en(addr_minus_en),
        
        .waddr(waddr),
        .din(din)
    );

    add_dat ad1(
        .clk(clk),
        .data(bridge),
        .S_out(S)
    );
    
endmodule