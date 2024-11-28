package env_block;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import scoreboard::*;
    import agent_block::*;
    
    class env_block extends uvm_env;
        `uvm_component_utils(env_block)
        
        agent_block agent_block_i;
        scoreboard scoreboard_i;
    
        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction : new
    
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            agent_block_i = agent_block::type_id::create("agent_block_i", this);
            scoreboard_i = scoreboard::type_id::create("scoreboard_i", this);
        endfunction : build_phase

        function void connect_phase(uvm_phase phase);
            agent_block_i.monitor_block_i.item_collected_port.connect(scoreboard_i.scoreboard_block);
        endfunction : connect_phase
        
    endclass 
endpackage