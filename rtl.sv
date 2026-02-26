// Code your design here
module comparator_4bit (
    input  logic [3:0] a,
    input  logic [3:0] b,
    output logic gt,
    output logic lt,
    output logic eq
);

    always_comb begin
        gt = (a > b);
        lt = (a < b);
        eq = (a == b);
    end

endmodule
