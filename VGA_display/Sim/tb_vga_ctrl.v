`timescale 1ns/1ns  
module tb_vga_ctrl();  

////  
// \* Parameter and Internal Signal \//  
////  
// wire define  
wire locked;  
wire rst_n;  
wire vga_clk;  

// reg define  
reg sys_clk;  
reg sys_rst_n;  
reg [15:0] pix_data;  

// Internal signals for VGA module outputs  
wire [9:0] pix_x;  
wire [9:0] pix_y;  
wire hsync;  
wire vsync;  
wire [15:0] rgb;  

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

// rst_n: VGA module reset signal  
assign rst_n = sys_rst_n & locked;  

// pix_data: input pixel color information  
always @(posedge vga_clk or negedge rst_n)  
begin  
    if (rst_n == 1'b0)  
        pix_data <= 16'h0000; // Reset pixel data to black  
    else  
        pix_data <= 16'hffff; // Set pixel data to white  
end  

////  
// \* Instantiation \//  
////  

// ------------- clk_gen_inst -------------  
clk_gen clk_gen_inst (  
    .areset (~sys_rst_n),  // Input reset signal, active high, 1-bit  
    .inclk0 (sys_clk),     // Input 50MHz clock, 1-bit  
    .c0 (vga_clk),         // Output VGA working clock, 25MHz, 1-bit  
    .locked (locked)       // Output PLL locked signal, 1-bit  
);  

// ------------- vga_ctrl_inst -------------  
vga_ctrl vga_ctrl_inst (  
    .vga_clk (vga_clk),    // Input working clock, 25MHz, 1-bit  
    .sys_rst_n (rst_n),    // Input reset signal, active low, 1-bit  
    .pix_data (pix_data),  // Input pixel color information, 16-bit  

    .pix_x (pix_x),        // Output VGA active display area pixel X-coordinate, 10-bit  
    .pix_y (pix_y),        // Output VGA active display area pixel Y-coordinate, 10-bit  
    .hsync (hsync),        // Output horizontal sync signal, 1-bit  
    .vsync (vsync),        // Output vertical sync signal, 1-bit  
    .rgb (rgb)             // Output pixel color information, 16-bit  
);  

endmodule   