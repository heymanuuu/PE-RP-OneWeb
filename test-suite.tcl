set ns [new Simulator]
$ns set-address-format hierarchical
proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exec nam ./nam/test8.nam 
}
# Create trace files
set tracefile [open ./tr/test8.tr w]
$ns trace-all $tracefile
set nf [open ./nam/test8.nam w]
$ns namtrace-all $nf
set count 0 ;#count num of link/chain

# createNodes
set nodeFile [open "/mnt/hgfs/share/chain/hier_createNode.txt" r]

set lines [split [read $nodeFile] "\n"]

close $nodeFile

array set nodes {}
set current_domain ""
set current_cluster ""

set cnt 0
foreach line $lines {

    if {[regexp {^domain(\d+)_cluster(\d+)$} $line -> domain cluster]} {
        set numOfNode 0

        set current_domain $domain
        set current_cluster $cluster
puts "$domain $cluster"
        continue
    }
    
    if {$current_domain ne "" && $current_cluster ne ""} {
        incr cnt
        set node_addr "${current_domain}.${current_cluster}.$numOfNode"
        set node [$ns node $node_addr]
        set nodes($line) $node
        puts "nodes($line)"
        puts $node_addr
        incr numOfNode
    }
}
puts "nums of nodes : $cnt"
# Topology information :
lappend domain1 1
AddrParams set domain_num_ $domain1
lappend cluster1 8
AddrParams set cluster_num_ $cluster1
lappend eilastlevel1 78 81 83 80 79 76 74 75
AddrParams set nodes_num_ $eilastlevel1


# createCoLinks
set file [open "/mnt/hgfs/share/chain/oneweb2_chain.txt" r]
set oneweb1_chain [read $file]
close $file

set link_items [split $oneweb1_chain " "]

set oneweb_regex {ONEWEB-\d{4}_\d{5}}

foreach item $link_items {

    set matches [regexp -all -inline $oneweb_regex $item]

    set num_matches [llength $matches]
    if {$num_matches == 2} {
        set satellite1 [lindex $matches 0]
        set satellite2 [lindex $matches 1]
puts "$satellite1 $satellite2"

        $ns duplex-link $nodes($satellite1) $nodes($satellite2) 50Mb 1ms DropTail
        puts "create link/chain of co-directional orbit：$satellite1 $satellite2"
        set count [expr $count + 1]
    } 
}
proc createReverseLinks {filename1 filename2} {
    global ns nodes
    set file1 [open $filename1 r]
    set file2 [open $filename2 r]
    set content1 [split [read $file1] "\n"]
    set content2 [split [read $file2] "\n"]
    close $file1
    close $file2

    array set linkGroups {}
    for {set i 0} {$i < 12} {incr i} {
        set linkGroups($i) ""
    }

    for {set i 0} {$i < [llength $content1]} {incr i} {
        set satellite1 [lindex $content1 $i]
        if {$satellite1 != ""} {

            set count 0
            for {set j $i} {$count < 12} {incr count; incr j 4} {
                set index [expr {$j % [llength $content2]}]
                set satellite2 [lindex $content2 $index]
                if {$satellite2 != ""} {
                    
                    switch -exact $count {
                        "0" {
                           $ns duplex-link $nodes($satellite1) $nodes($satellite2) 50Mb 1ms DropTail
                           $ns rtmodel Deterministic {0.5 1800 3300 -} $nodes($satellite1) $nodes($satellite2)
                        }
"1" {
                 $ns rtmodel Deterministic {300.5 300 3300 -} $nodes($satellite1) $nodes($satellite2)55573
                        }
                        "2" {
                  $ns rtmodel Deterministic {600.5 300 3300 -} $nodes($satellite1) $nodes($satellite2)
                        }
                        "3" {
                  $ns rtmodel Deterministic {900.5 300 3300 -} $nodes($satellite1) $nodes($satellite2)
                        }
                        "4" {
                  $ns rtmodel Deterministic {1200.5 300 3300 -} $nodes($satellite1) $nodes($satellite2)
                        }
                        "5" {
                  $ns rtmodel Deterministic {1500.5 300 3300 -} $nodes($satellite1) $nodes($satellite2)
                        }
                        "6" {
                  $ns rtmodel Deterministic {1800.5 300 3300 -} $nodes($satellite1) $nodes($satellite2)
                        }
                        "7" {
                   $ns rtmodel Deterministic {2100.5 300 3300 -} $nodes($satellite1) $nodes($satellite2)
                        }
                        "8" {
                   $ns rtmodel Deterministic {2400.5 300 3300 -} $nodes($satellite1) $nodes($satellite2)
                        }
                        "9" {
                   $ns rtmodel Deterministic {2700.5 300 3300 -} $nodes($satellite1) $nodes($satellite2)
                        }
                        "10" {
                    $ns rtmodel Deterministic {3000.5 300 3300 -} $nodes($satellite1) $nodes($satellite2)
                        }
"11" {
                    $ns rtmodel Deterministic {3300.5 300 3300 -} $nodes($satellite1) $nodes($satellite2)
                        }
                    }
                    puts "create link of reverse orbit: $satellite1 $satellite2"
                    lappend linkGroups($count) "$satellite1 $satellite2"
                }
            }
        }
    }
    set outputFile [open "/mnt/hgfs/share/chain/linksByPeriod.txt" w]
    for {set i 0} {$i < 12} {incr i} {
        puts $outputFile "\"$i\""
        foreach link $linkGroups($i) {
            puts $outputFile $link
        }
    }
    close $outputFile
}
proc createLinkCost {filename} {
    global ns nodes
    set fileId [open $filename r]
    set fileContents [read $fileId]
close $fileId
    foreach line [split $fileContents "\n"] {
            set fields [split $line " "]
            set satellite1 [lindex $fields 0]
            set satellite2 [lindex $fields 1]
            set delay [lindex $fields 2]   
$ns cost $nodes($satellite1) $nodes($satellite2) $delay
            $ns cost $nodes($satellite2) $nodes($satellite1) $delay           
    }
}
createLinkCost "/mnt/hgfs/share/chain/coDirectional_chain_delay.txt"
createReverseLinks "/mnt/hgfs/share/chain/orbit12.txt" "/mnt/hgfs/share/chain/orbit1.txt"
createLinkCost "/mnt/hgfs/share/chain/reverseLink_delay.txt"
#vwait forever
set udp0 [new Agent/UDP]
$ns attach-agent $nodes(ONEWEB-0257_48975) $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
$cbr0 set packetSize_ 1000
$cbr0 set rate_ 1M
#$cbr0 set interval_ 0.4ms
set null0 [new Agent/Null]
$ns attach-agent $nodes(ONEWEB-0497_54116) $null0

$ns connect $udp0 $null0
$ns at 1.0 "$cbr0 start"

$ns rtmodel Deterministic {10 0.68 9.32 -} $nodes(ONEWEB-0490_54113)
#$ns rtmodel-at 10.0 down $nodes(ONEWEB-0490_54113)
#$ns rtmodel-at 15.0 up $nodes(ONEWEB-0490_54113)
#$ns rtmodel-at 600.0 down $nodes(ONEWEB-0661_55821) $nodes(ONEWEB-0563_55800)
#$ns at 700.1 "$ns compute-routes"
$ns at 61.0 "$cbr0 stop"

for {set i 0.0001} {$i < 100} {set i [expr $i+2.8]} {
  puts $i
  $ns at $i "$ns compute-routes"
}

$ns at 4000 "finish"
$ns run
