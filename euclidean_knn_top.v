`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology Calicut
// Engineer: Nambiar Akshay
//
// Create Date: 19.06.2026
// Design Name:
// Module Name: euclidean_knn_top
// Description:
// 
//////////////////////////////////////////////////////////////////////////////////

module euclidean_knn_top(

    input clk,
    input reset,
    input start,
    input [7:0] x0,
    input [7:0] x1,
    input [7:0] x2,
    input [7:0] x3,

    output done,

    output [6:0] nearest_neighbor_index,
    output [17:0] minimum_distance

);

//====================================================
// Address Generation
//====================================================

reg [6:0] addr;
reg [6:0] index;

//====================================================
// Distance From Current BRAM Vector
//====================================================

wire [17:0] distance;

//====================================================
// Running Minimum Registers
//====================================================

reg [17:0] min_distance_reg;
reg [6:0]  min_index_reg;

//====================================================
// FSM Control
//====================================================

// Step 1: Widened to 4 bits to accommodate 9 states
reg [3:0] state;
reg [2:0] done_count;

//====================================================
// FSM States
//====================================================

// Step 2: All states re-encoded as 4-bit localparams
localparam S_IDLE  = 4'd0;

localparam S_ADDR  = 4'd1;

localparam S_WAIT1 = 4'd2;
localparam S_WAIT2 = 4'd3;
localparam S_WAIT3 = 4'd4;
localparam S_WAIT4 = 4'd5;
localparam S_WAIT5 = 4'd6;

localparam S_STORE = 4'd7;

localparam S_DONE  = 4'd8;

//====================================================
// Search Parameters
//====================================================

// Change this when the COE file has a different number of windows
localparam LAST_WINDOW  = 7'd93;

// Largest representable 18-bit value; used to seed the running minimum
localparam MAX_DISTANCE = 18'h3FFFF;

//====================================================
// Output Logic
//====================================================

assign done =
    (state == S_DONE) &&
    (done_count == 3'd6);

assign nearest_neighbor_index = min_index_reg;

assign minimum_distance = min_distance_reg;

// Step 3: initial block removed; all init moved into synchronous reset below

//====================================================
// BRAM + Euclidean Engine
//====================================================

bram_euclidean_top DIST_ENGINE(

    .clk(clk),

    .addr(addr),

    .x0(x0),
    .x1(x1),
    .x2(x2),
    .x3(x3),

    .distance(distance)

);

//====================================================
// Main Search FSM
//====================================================

// Steps 4 & 5: Synchronous reset added; FSM wrapped inside else begin
always @(posedge clk)
begin

    if(reset)
    begin

        state <= S_IDLE;

        addr  <= 0;
        index <= 0;

        done_count <= 0;

        min_distance_reg <= MAX_DISTANCE;

        min_index_reg <= 0;

    end

    else
    begin

        case(state)

        //------------------------------------------------
        // Step 6: Wait for Start Signal
        //------------------------------------------------

        S_IDLE:
        begin

            done_count <= 0;

            if(start)
            begin

                addr  <= 0;
                index <= 0;

                min_distance_reg <= MAX_DISTANCE;
                min_index_reg    <= 0;

                state <= S_ADDR;

            end

        end

        //------------------------------------------------
        // Present BRAM Address
        //------------------------------------------------

        S_ADDR:
        begin

            addr  <= index;
            state <= S_WAIT1;

        end

        //------------------------------------------------
        // BRAM Pipeline Delay
        //------------------------------------------------

        S_WAIT1: state <= S_WAIT2;
        S_WAIT2: state <= S_WAIT3;
        S_WAIT3: state <= S_WAIT4;
        S_WAIT4: state <= S_WAIT5;
        S_WAIT5: state <= S_STORE;

        //------------------------------------------------
        // Compare Distance
        //------------------------------------------------

        S_STORE:
        begin

            //------------------------------------------------
            // First Vector Automatically Becomes Candidate
            //------------------------------------------------

            if(index == 7'd0)
            begin

                min_distance_reg <= distance;
                min_index_reg    <= 7'd0;

            end

            //------------------------------------------------
            // Running Minimum Update
            //------------------------------------------------

            else if(distance < min_distance_reg)
            begin

                min_distance_reg <= distance;
                min_index_reg    <= index;

            end

            //------------------------------------------------
            // Finished Searching All Windows?
            //------------------------------------------------

            if(index == LAST_WINDOW)
            begin

                state <= S_DONE;

            end
            else
            begin

                index <= index + 1'b1;
                state <= S_ADDR;

            end

        end

        //------------------------------------------------
        // Step 7: Hold Final Result, then Return to IDLE
        //------------------------------------------------

        S_DONE:
        begin

            if(done_count < 3'd6)
            begin

                done_count <= done_count + 1'b1;

            end

            else
            begin

                state <= S_IDLE;

            end

        end

        //------------------------------------------------
        // Step 8: Default Recovery to IDLE
        //------------------------------------------------

        default:
        begin

            state <= S_IDLE;

        end

        endcase

    end

end

endmodule
