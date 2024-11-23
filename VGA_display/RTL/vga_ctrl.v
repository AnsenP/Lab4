module vga_ctrl(  
    input wire vga_clk,       // Input clock, 25MHz  
    input wire sys_rst_n,     // Active-low reset signal  
    input wire [15:0] pix_data, // Input pixel color data  

    output reg [9:0] pix_x,   // Current pixel X coordinate  
    output reg [9:0] pix_y,   // Current pixel Y coordinate  
    output reg hsync,         // Horizontal sync signal  
    output reg vsync,         // Vertical sync signal  
    output reg [15:0] rgb     // Output pixel color data  
);  

    // VGA 640x480 @ 60Hz timing parameters  
    parameter H_SYNC_PULSE   = 96;  
    parameter H_BACK_PORCH   = 48;  
    parameter H_ACTIVE_VIDEO = 640;  
    parameter H_FRONT_PORCH  = 16;  
    parameter H_LINE_TOTAL   = 800;  

    parameter V_SYNC_PULSE   = 2;  
    parameter V_BACK_PORCH   = 33;  
    parameter V_ACTIVE_VIDEO = 480;  
    parameter V_FRONT_PORCH  = 10;  
    parameter V_FRAME_TOTAL  = 525;  

    // Internal counters  
    reg [9:0] h_count;  
    reg [9:0] v_count;  

    // Horizontal and vertical sync generation  
    always @(posedge vga_clk or negedge sys_rst_n) begin  
        if (!sys_rst_n) begin  
            h_count <= 0;  
            v_count <= 0;  
            hsync <= 1;  
            vsync <= 1;  
        end else begin  
            // Horizontal counter  
            if (h_count < H_LINE_TOTAL - 1)  
                h_count <= h_count + 1;  
            else begin  
                h_count <= 0;  
                // Vertical counter  
                if (v_count < V_FRAME_TOTAL - 1)  
                    v_count <= v_count + 1;  
                else  
                    v_count <= 0;  
            end  

            // Generate hsync pulse  
            if (h_count < H_SYNC_PULSE)  
                hsync <= 0;  
            else  
                hsync <= 1;  

            // Generate vsync pulse  
            if (v_count < V_SYNC_PULSE)  
                vsync <= 0;  
            else  
                vsync <= 1;  
        end  
    end  

    // Pixel position calculation  
    always @(posedge vga_clk or negedge sys_rst_n) begin  
        if (!sys_rst_n) begin  
            pix_x <= 0;  
            pix_y <= 0;  
        end else begin  
            if (h_count >= (H_SYNC_PULSE + H_BACK_PORCH) &&  
                h_count < (H_SYNC_PULSE + H_BACK_PORCH + H_ACTIVE_VIDEO))  
                pix_x <= h_count - (H_SYNC_PULSE + H_BACK_PORCH);  
            else  
                pix_x <= 0;  

            if (v_count >= (V_SYNC_PULSE + V_BACK_PORCH) &&  
                v_count < (V_SYNC_PULSE + V_BACK_PORCH + V_ACTIVE_VIDEO))  
                pix_y <= v_count - (V_SYNC_PULSE + V_BACK_PORCH);  
            else  
                pix_y <= 0;  
        end  
    end  

    // Output pixel data  
    always @(posedge vga_clk or negedge sys_rst_n) begin  
        if (!sys_rst_n)  
            rgb <= 16'h0000; // Default to black on reset  
        else if (h_count >= (H_SYNC_PULSE + H_BACK_PORCH) &&  
                 h_count < (H_SYNC_PULSE + H_BACK_PORCH + H_ACTIVE_VIDEO) &&  
                 v_count >= (V_SYNC_PULSE + V_BACK_PORCH) &&  
                 v_count < (V_SYNC_PULSE + V_BACK_PORCH + V_ACTIVE_VIDEO))  
            rgb <= pix_data; // Display pixel data  
        else  
            rgb <= 16'h0000; // Blank outside active video area  
    end  

endmodule  