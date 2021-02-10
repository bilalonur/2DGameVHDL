set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
 
set_property PACKAGE_PIN V17 [get_ports {sw[0]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
    set_property PACKAGE_PIN V16 [get_ports {sw[1]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
    set_property PACKAGE_PIN W16 [get_ports {sw[2]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
    set_property PACKAGE_PIN W17 [get_ports {sw[3]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
        
        
        
        set_property PACKAGE_PIN U16 [get_ports {try[0]}]					
            set_property IOSTANDARD LVCMOS33 [get_ports {try[0]}]
        set_property PACKAGE_PIN E19 [get_ports {try[1]}]                    
            set_property IOSTANDARD LVCMOS33 [get_ports {try[1]}]
        set_property PACKAGE_PIN U19 [get_ports {try[2]}]                    
            set_property IOSTANDARD LVCMOS33 [get_ports {try[2]}]
        set_property PACKAGE_PIN V19 [get_ports {try[3]}]                    
            set_property IOSTANDARD LVCMOS33 [get_ports {try[3]}]
        
 
 set_property PACKAGE_PIN W7 [get_ports {segmnt[0]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {segmnt[0]}]
    set_property PACKAGE_PIN W6 [get_ports {segmnt[1]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {segmnt[1]}]
    set_property PACKAGE_PIN U8 [get_ports {segmnt[2]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {segmnt[2]}]
    set_property PACKAGE_PIN V8 [get_ports {segmnt[3]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {segmnt[3]}]
    set_property PACKAGE_PIN U5 [get_ports {segmnt[4]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {segmnt[4]}]
    set_property PACKAGE_PIN V5 [get_ports {segmnt[5]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {segmnt[5]}]
    set_property PACKAGE_PIN U7 [get_ports {segmnt[6]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {segmnt[6]}]
    
    set_property PACKAGE_PIN V7 [get_ports pointcontrol]                            
        set_property IOSTANDARD LVCMOS33 [get_ports pointcontrol]
    
    set_property PACKAGE_PIN U2 [get_ports {anodd[0]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {anodd[0]}]
    set_property PACKAGE_PIN U4 [get_ports {anodd[1]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {anodd[1]}]
    set_property PACKAGE_PIN V4 [get_ports {anodd[2]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {anodd[2]}]
    set_property PACKAGE_PIN W4 [get_ports {anodd[3]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {anodd[3]}]

 
 
set_property PACKAGE_PIN U18 [get_ports btn[3]]						
            set_property IOSTANDARD LVCMOS33 [get_ports btn[3]]
            
        set_property PACKAGE_PIN T18 [get_ports btn[0]]                        
            set_property IOSTANDARD LVCMOS33 [get_ports btn[0]]
    set_property PACKAGE_PIN U17 [get_ports btn[1]]                        
                set_property IOSTANDARD LVCMOS33 [get_ports btn[1]]
                
        set_property PACKAGE_PIN W19 [get_ports btn[2]]                        
            set_property IOSTANDARD LVCMOS33 [get_ports btn[2]]
#        set_property PACKAGE_PIN T17 [get_ports btn[3]]                        
#            set_property IOSTANDARD LVCMOS33 [get_ports btn[3]]

set_property PACKAGE_PIN G19 [get_ports {vgaRed[0]}]				
            set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[0]}]
        set_property PACKAGE_PIN H19 [get_ports {vgaRed[1]}]                
            set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[1]}]
        set_property PACKAGE_PIN J19 [get_ports {vgaRed[2]}]                
            set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[2]}]
        
        set_property PACKAGE_PIN N18 [get_ports {vgaBlue[0]}]                
            set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[0]}]
        set_property PACKAGE_PIN L18 [get_ports {vgaBlue[1]}]                
            set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[1]}]
            
        set_property PACKAGE_PIN J17 [get_ports {vgaGreen[0]}]                
            set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[0]}]
        set_property PACKAGE_PIN H17 [get_ports {vgaGreen[1]}]                
            set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[1]}]
        set_property PACKAGE_PIN G17 [get_ports {vgaGreen[2]}]                
            set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[2]}]
        
        set_property PACKAGE_PIN P19 [get_ports Hsync]                        
            set_property IOSTANDARD LVCMOS33 [get_ports Hsync]
        set_property PACKAGE_PIN R19 [get_ports Vsync]                        
            set_property IOSTANDARD LVCMOS33 [get_ports Vsync]
