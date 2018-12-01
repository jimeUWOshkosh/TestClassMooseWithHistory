#!/bin/bash
# prove -lv --merge t/run.t
# prove -lv --merge t/run.t :: TestsFor::Person::Customer TestsFor::Person::Employee
#
# prove -lv --merge t/tcm.t :: --tc TestsFor::Person::Customer --tc TestsFor::Person::Employee --report
# prove -lv --merge t/tcm.t :: --tc TestsFor::Person::Customer
# prove -lv --merge t/tcm.t :: --failures
 prove -lv --merge t/tcm.t :: --report
# prove -l t   ## will not generate History report
