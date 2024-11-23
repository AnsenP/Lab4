module vga_char(  
    input wire sys_clk,       // Input system clock, frequency 50MHz  
    input wire sys_rst_n,     // Input reset signal, active low  

    output wire hsync,        // Output horizontal sync signal  
    output wire vsync,        // Output vertical sync signal  
    output wire [15:0] rgb    // Output pixel color information  
);  

    // Internal signal declarations  
    wire vga_clk;             // VGA working clock, frequency 25MHz  
    wire locked;              // PLL locked signal  
    wire rst_n;               // VGA module reset signal  
    wire [9:0] pix_x;         // VGA active display area X coordinate  
    wire [9:0] pix_y;         // VGA active display area Y coordinate  
    wire [15:0] pix_data;     // VGA pixel color information  

    // rst_n: VGA module reset signal  
    assign rst_n = (sys_rst_n & locked);  

    // Module instantiations  

    //------------- clk_gen_inst -------------  
    clk_gen clk_gen_inst (  
        .areset(~sys_rst_n),  // Input reset signal, active high, 1 bit  
        .inclk0(sys_clk),     // Input 50MHz crystal oscillator clock, 1 bit  

        .c0(vga_clk),         // Output VGA working clock, frequency 25MHz, 1 bit  
        .locked(locked)       // Output PLL locked signal, 1 bit  
    );  

    //------------- vga_ctrl_inst -------------  
    vga_ctrl vga_ctrl_inst (  
        .vga_clk(vga_clk),    // Input working clock, frequency 25MHz, 1 bit  
        .sys_rst_n(rst_n),    // Input reset signal, active low, 1 bit  
        .pix_data(pix_data),  // Input pixel color information, 16 bits  

        .pix_x(pix_x),        // Output VGA active display area pixel X coordinate, 10 bits  
        .pix_y(pix_y),        // Output VGA active display area pixel Y coordinate, 10 bits  
        .hsync(hsync),        // Output horizontal sync signal, 1 bit  
        .vsync(vsync),        // Output vertical sync signal, 1 bit  
        .rgb(rgb)             // Output pixel color information, 16 bits  
    );  

    //------------- vga_pic_inst -------------  
    vga_pic vga_pic_inst (  
        .vga_clk(vga_clk),    // Input working clock, frequency 25MHz, 1 bit  
        .sys_rst_n(rst_n),    // Input reset signal, active low, 1 bit  
        .pix_x(pix_x),        // Input VGA active display area pixel X coordinate, 10 bits  
        .pix_y(pix_y),        // Input VGA active display area pixel Y coordinate, 10 bits  

        .pix_data(pix_data)   // Output pixel color information, 16 bits  
    );  

endmodule