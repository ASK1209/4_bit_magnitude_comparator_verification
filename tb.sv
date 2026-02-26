class transaction;
        rand bit [3:0] a;
        rand bit [3:0] b;

        constraint valid_range {
            a inside {[0:15]};
            b inside {[0:15]};
        }
    endclass



module tb;

    logic clk;
    logic [3:0] a, b;
    logic gt, lt, eq;

    // DUT
    comparator_4bit dut (
        .a(a),
        .b(b),
        .gt(gt),
        .lt(lt),
        .eq(eq)
    );

    // Clock generation
    always #5 clk = ~clk;
    

    transaction tr;

    // -----------------------------
    // Functional Coverage
    // -----------------------------
    covergroup cg @(posedge clk);
        coverpoint a;
        coverpoint b;

        compare_result : coverpoint {gt,lt,eq} {
            bins greater = {3'b100};
            bins lesser  = {3'b010};
            bins equal   = {3'b001};
        }

    endgroup

    cg coverage = new();

    // -----------------------------
    // Assertions
    // -----------------------------

    // Only one output high at a time
    property one_hot_check;
        @(posedge clk)
        (gt + lt + eq) == 1;
    endproperty

    assert property (one_hot_check)
        else $error("ERROR: Outputs not one-hot!");

    // Correct behavior assertion
    property functional_check;
        @(posedge clk)
        (a > b) |-> gt;
    endproperty

    assert property (functional_check)
        else $error("ERROR: Functional mismatch!");

    // -----------------------------
    // Scoreboard
    // -----------------------------
    task check_result();
        if (a > b && gt !== 1) $error("Mismatch: A>B failed");
        if (a < b && lt !== 1) $error("Mismatch: A<B failed");
        if (a == b && eq !== 1) $error("Mismatch: A==B failed");
    endtask

    // -----------------------------
    // Test Sequence
    // -----------------------------
    initial begin
      $dumpfile("dump.vcd");
		$dumpvars(0, tb);
        clk = 0;
        tr = new();

      repeat (500) begin
            assert(tr.randomize());
            a = tr.a;
            b = tr.b;
            #10;
            check_result();
            coverage.sample();
        end

        $display("Coverage = %0.2f %%", coverage.get_coverage());
        $finish;
    end

endmodule
