`timescale 10ps/1ps

module D_p_SRAM_tb();

    //spec的引脚定义
    reg clk;//时钟，AB共用了
    reg [12:0] A;//A地址
    reg [12:0] B;//B地址
    reg [31:0] IA;//输入
    reg [31:0] IB;
    wire [31:0] OA;//输出
    wire [31:0] OB;
    reg DVSE;//延迟选项启用信号
    reg [3:0] DVS;//延迟选项控制字符
    reg CSAN;//A端芯片选择
    reg CSBN;//B端芯片选择
    reg WEAN;//A端写入b bytes启用信号 1读数据 0写数据
    reg WEBN;//功能同上，但是B端
    reg NAP;//NAP模式？不懂，感觉是休眠的

    

/*spec上的Timing specification，但好像对自己没啥用
    parameter Taa = 1.92;
   parameter Toh = 1.54; 
    parameter Trc = 2.39;
    parameter Tas = 0.53;
    parameter Tah = 0.16;
    parameter Tcss = 0.66;
    parameter Teshr = 0.38;
    parameter Tcshw = 0.38;
    parameter Thpw = 0.5;
    parameter Tipw = 0.7;
    parameter Twc = 2.4;
    parameter Tws = 0.27;
    parameter Twh = 0.17;
    parameter Td = 0.17;
    parameter Tdh = 0.08;
    parameter Tnaph = 0.28;
    parameter Tnap_csh = 1.03;*/
    
    initial begin//时钟周期为5ns，操作时间最长2.4ns
        clk = 1'b0;
        forever #250 clk = ~clk;//每隔2.5ns时钟电平变换
    end

    //初始化
    initial begin
        A = 13'h0;
        B = 13'h0;
        WEAN = 1;//只读
        WEBN = 1;//只读
        DVSE = 0;
        DVS = 4'h0;
        CSAN = 0;
        CSBN = 0;
        NAP = 0;
        IA = 32'h0;
        IB = 32'h0;

        #5000 //等待10个时钟，系统稳定后开始第一题

        //Q1：A口写入，B口读入
        //数据INPUT
        IA=32'h0000001A;
        IB=32'h0000002B;
        //A口写入
        WEAN = 0;
        //只有OA有输出，OA=IA,OB=invaid

        #5000 //稳定系统

        //复位
        A = 13'h0;
        B = 13'h0;
        WEAN = 1;//只读
        WEBN = 1;//只读
        DVSE = 0;
        DVS = 4'h0;
        CSAN = 0;
        CSBN = 0;
        NAP = 0;
        IA = 32'h0;
        IB = 32'h0;

        #5000 //稳定系统

        //Q2:A口写入，A口读入B口再读入
        //数据input
        IA = 32'h1A000000;
        IB = 32'h2B000000;
        //A口写入
        WEAN = 0;
        #1000
        //AB口读入
        WEAN = 1;
        WEBN = 1;
    end

    SJLA40_8192X32X1CM8  my_module(
        .CKA(clk),
        .CKB(clk),
        .DVSE(DVSE),
        .DVS0(DVS[0]),
        .DVS1(DVS[1]),
        .DVS2(DVS[2]),
        .DVS3(DVS[3]),
        .WEAN(WEAN),
        .WEBN(WEBN), 
        .CSAN(CSAN),
        .CSBN(CSBN),
        .NAP(NAP),

        .A0(A[0]), .A1(A[1]), .A2(A[2]), .A3(A[3]), .A4(A[4]), .A5(A[5]), .A6(A[6]),
        .A7(A[7]), .A8(A[8]), .A9(A[9]), .A10(A[10]), .A11(A[11]), .A12(A[12]),

        .B0(B[0]), .B1(B[1]), .B2(B[2]), .B3(B[3]), .B4(B[4]), .B5(B[5]), .B6(B[6]),
        .B7(B[7]), .B8(B[8]), .B9(B[9]), .B10(B[10]), .B11(B[11]), .B12(B[12]),

        .DIA0(IA[0]), .DIA1(IA[1]), .DIA2(IA[2]), .DIA3(IA[3]), .DIA4(IA[4]), .DIA5(IA[5]), 
        .DIA6(IA[6]), .DIA7(IA[7]), .DIA8(IA[8]), .DIA9(IA[9]), .DIA10(IA[10]), .DIA11(IA[11]),
        .DIA12(IA[12]), .DIA13(IA[13]), .DIA14(IA[14]), .DIA15(IA[15]), .DIA16(IA[16]), .DIA17(IA[17]),  
        .DIA18(IA[18]), .DIA19(IA[19]), .DIA20(IA[20]), .DIA21(IA[21]), .DIA22(IA[22]), .DIA23(IA[23]),  
        .DIA24(IA[24]), .DIA25(IA[25]), .DIA26(IA[26]), .DIA27(IA[27]), .DIA28(IA[28]), .DIA29(IA[29]),  
        .DIA30(IA[30]), .DIA31(IA[31]),

        .DIB0(IB[0]), .DIB1(IB[1]), .DIB2(IB[2]), .DIB3(IB[3]), .DIB4(IB[4]), .DIB5(IB[5]),
        .DIB6(IB[6]), .DIB7(IB[7]), .DIB8(IB[8]), .DIB9(IB[9]), .DIB10(IB[10]), .DIB11(IB[11]), 
        .DIB12(IB[12]), .DIB13(IB[13]), .DIB14(IB[14]), .DIB15(IB[15]), .DIB16(IB[16]), .DIB17(IB[17]), 
        .DIB18(IB[18]), .DIB19(IB[19]), .DIB20(IB[20]), .DIB21(IB[21]), .DIB22(IB[22]), .DIB23(IB[23]),
        .DIB24(IB[24]), .DIB25(IB[25]), .DIB26(IB[26]), .DIB27(IB[27]), .DIB28(IB[28]), .DIB29(IB[29]),
        .DIB30(IB[30]), .DIB31(IB[31]), 

        .DOA0(OA[0]), .DOA1(OA[1]), .DOA2(OA[2]), .DOA3(OA[3]), .DOA4(OA[4]), .DOA5(OA[5]), 
        .DOA6(OA[6]), .DOA7(OA[7]), .DOA8(OA[8]), .DOA9(OA[9]), .DOA10(OA[10]), .DOA11(OA[11]),
        .DOA12(OA[12]), .DOA13(OA[13]), .DOA14(OA[14]), .DOA15(OA[15]), .DOA16(OA[16]), .DOA17(OA[17]), 
        .DOA18(OA[18]), .DOA19(OA[19]), .DOA20(OA[20]), .DOA21(OA[21]), .DOA22(OA[22]), .DOA23(OA[23]),
        .DOA24(OA[24]), .DOA25(OA[25]), .DOA26(OA[26]), .DOA27(OA[27]), .DOA28(OA[28]), .DOA29(OA[29]), 
        .DOA30(OA[30]), .DOA31(OA[31]),  
  
        .DOB0(OB[0]), .DOB1(OB[1]), .DOB2(OB[2]), .DOB3(OB[3]), .DOB4(OB[4]), .DOB5(OB[5]), 
        .DOB6(OB[6]), .DOB7(OB[7]), .DOB8(OB[8]), .DOB9(OB[9]), .DOB10(OB[10]), .DOB11(OB[11]), 
        .DOB12(OB[12]), .DOB13(OB[13]), .DOB14(OB[14]), .DOB15(OB[15]), .DOB16(OB[16]), .DOB17(OB[17]), 
        .DOB18(OB[18]), .DOB19(OB[19]), .DOB20(OB[20]), .DOB21(OB[21]), .DOB22(OB[22]), .DOB23(OB[23]), 
        .DOB24(OB[24]), .DOB25(OB[25]), .DOB26(OB[26]), .DOB27(OB[27]), .DOB28(OB[28]), .DOB29(OB[29]), 
        .DOB30(OB[30]), .DOB31(OB[31])
    );

endmodule


