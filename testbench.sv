module testbench;
    reg clk;
    reg reset;
    wire [3:0] count;

    //Instancia o módulo contador_sequencial
    contador_sequencial uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    //clock
    initial begin
        clk = 0;
        forever #50 clk = ~clk; // Clock com período de 50 unidades de tempo
    end

    //Gera os casos de teste
    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0, testbench);
        
      	reset = 1;
      	#1;
      	reset = 0;

        // Testa o contador por 5 segundos (500 unidades de tempo)
        #500;

        // Aplica reset novamente
        reset = 1;
        #10;
        reset = 0;

        // Testa o contador por mais 12 segundos (1200 unidades de tempo)
        #1200;

        $finish;
    end

    //Monitora a saída do contador
    initial begin
        $monitor("Time = %0d, Count = %b", $time, count);
    end
endmodule
