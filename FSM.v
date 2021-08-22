module FSM (
    input clk,
    input write_mode,

    input zero,
    output  sel,  output  first,
    output  addr_minus_en,

    output  SRAM_re, SRAM_we,

    output busy,
    input reset
);
    reg [2:0]S;
    wire [2:0] S1;

    reg reg_SRAM_we,reg_SRAM_re,reg_sel,reg_first,reg_addr_minus_en,reg_busy;

    assign SRAM_re=reg_SRAM_re;
    assign sel=reg_sel;
    assign first=reg_first;
    assign addr_minus_en=reg_addr_minus_en;
    assign busy=reg_busy;
    assign SRAM_we=reg_SRAM_we;

    always @(posedge reset) begin
        S<=3'b000;
    end

    assign S1=S;

    always @(posedge clk) begin
        S[0]<= zero & ~S1[0] & S1[1] &S1[2] | S1[0] & ~S1[1];
        S[1]<= ~S1[0] &(S1[1] |S1[2]) | S1[0] & ~S1[1] &S1[2];
        S[2]<= ~S1[1] & ~S1[2] | ~S1[0] & S1[1];
    end

    always @(*) begin
        if(write_mode) S=3'b111;
    end

    always @(*) begin
        case(S)
            3'b111:begin
                reg_SRAM_we=1;
                reg_SRAM_re<=0;
                reg_first<=0;
                reg_sel<=0;
                reg_addr_minus_en<=0;
                reg_busy<=1;
            end
            3'b000:begin
                reg_SRAM_we=0;
                reg_SRAM_re<=1;
                reg_first<=1;
                reg_sel<=1;
                reg_addr_minus_en<=0;
                reg_busy<=1;
            end
            3'b001:begin
                reg_SRAM_we=0;
                reg_SRAM_re<=0;
                reg_first<=0;
                reg_sel<=1;
                reg_addr_minus_en<=0;
                reg_busy<=1;
            end
            3'b010:begin
                reg_SRAM_we=0;
                reg_SRAM_re<=1;
                reg_first<=0;
                reg_sel<=0;
                reg_addr_minus_en<=1;
                reg_busy<=1;
            end
            3'b011:begin
                reg_SRAM_we=0;
                reg_SRAM_re<=1;
                reg_first<=0;
                reg_sel<=0;
                reg_addr_minus_en<=1;
                reg_busy<=1;
            end
            3'b100:begin
                reg_SRAM_we=0;
                reg_SRAM_re<=0;
                reg_first<=0;
                reg_sel<=0;
                reg_addr_minus_en<=0;
                reg_busy<=1;
            end
            3'b101:begin
                reg_SRAM_we=0;
                reg_SRAM_re<=0;
                reg_first<=0;
                reg_sel<=0;
                reg_addr_minus_en<=0;
                reg_busy<=0;
            end
        endcase
    end
endmodule
