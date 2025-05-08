*------------------------------------------------------------------------------*
* Program:    openexpand.ado
* Purpose:    Expands a string variable containing space-separated values
*                 into multiple binary (indicator) variables based on a value label
* Syntax:     openexpand varname [, Labelname(label)]
* Author:     Omondi Robert
* Version:    1.0
* Date:       06 May 2025
*------------------------------------------------------------------------------*

capture program drop openexpand
program define openexpand
    syntax varname(string) [, Labelname(name)]
    local var `varlist'
    local lblname = cond("`labelname'" != "", "`labelname'", " ")
    
    * Check if the label exists
    capture label list `lblname'
    if _rc {
        display as error "Label `lblname' does not exist"
        exit 198
    }
    
    * Get the maximum value defined in the label
    quietly label list `lblname'
    local maxval = r(max)
    
    * Generate indicator variables
    forvalues i = 1/`maxval' {
        * Get the label text for this value
        local lbl: label `lblname' `i', strict
        if "`lbl'" != "" {
            gen `var'_`i' = strpos(" " + `var' + " ", " `i' ") > 0
            label var `var'_`i' "`lbl'"
        }
    }
end