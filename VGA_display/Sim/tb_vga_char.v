`timescale 1ns/1ns  
module tb_vga_char();  

////  
// \* Parameter and Internal Signal \//  
////  
// wire define  
wire hsync;  
wire [15:0] rgb;  
wire vsync;  

// reg define  
reg sys_clk;  
reg sys_rst_n;  

////  
// \* Clk And Rst \//  
////  

// sys_clk and sys_rst_n initial assignment  
initial  
begin  
    sys_clk = 1'b1;  
    sys_rst_n <= 1'b0; // Use blocking assignment for initialization  
    #200  
    sys_rst_n <= 1'b1;  
end  

// sys_clk: generate clock signal  
always #10 sys_clk = ~sys_clk;  

////  
// \* Instantiation \//  
////  

// ------------- vga_char_inst -------------  
vga_char vga_char_inst (  
    .sys_clk (sys_clk),      // Input clock signal, 50MHz, 1-bit  
    .sys_rst_n (sys_rst_n),  // Input reset signal, active low, 1-bit  

    .hsync (hsync),          // Output horizontal sync signal, 1-bit  
    .vsync (vsync),          // Output vertical sync signal, 1-bit  
    .rgb (rgb)               // Output RGB image data, 16-bit  
);  

endmodule  