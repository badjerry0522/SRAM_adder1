module get_dat (
    input clk,
    input first,sel,
    input addr_minus_en,//minus singnal

    output [31:0] dout,
    output zero,

    input SRAM_re,SRAM_we,//sram singnal
    input [8:0] waddr, //write addr
    input [31:0] din //write data
);
    
    reg [8:0] reg_addr,addr,addr_minus;
    
    assign zero= ~(|reg_addr);

    SRAM SRAM1(
        .clk(clk),
        .we(SRAM_we),
        .addr(addr),
        .din(din), 
        .dout(dout)
    );

    always @(*) begin
        if(SRAM_we) addr<=waddr;
    end

    always @(*) begin
        if(first) addr<=0;
        else addr<=reg_addr; 
    end

    always @(posedge clk) begin
        if(sel) reg_addr<=dout;
        else reg_addr<=addr_minus;
    end

    always @(*) begin
        if(addr_minus_en) addr_minus<=reg_addr-1;
        else addr_minus=reg_addr;
    end


endmodule