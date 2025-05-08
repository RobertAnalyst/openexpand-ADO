{* *! version 1.0, Author: Omondi Robert @Evidence Action, Date: 08 May 2025 *}

{smcl}

{title:openexpand} [ado]

{phang}
{cmd:openexpand} expands a space-separated string variable into a set of indicator (dummy) variables using a specified numeric value label.

{marker description}{...}
{title:Description}

{pstd}
The {cmd:openexpand} program is designed for variables that contain multiple numeric codes as a space-separated string (e.g., "1 3 4"), typically resulting from open-ended, multiple-response survey questions. 
It generates a set of binary (0/1) indicator variables that identify the presence of each coded response in the original variable using a predefined numeric value label.

{pstd}
This is particularly helpful when working with survey data where multiple responses are collected as open-ended text, later coded numerically, but retained as string variables. 
Because Stata does not support value labels for string variables, {cmd:openexpand} uses a separately defined value label via the {cmd:labelname()} option to interpret and label the indicators correctly.

{marker syntax}{...}
{title:Syntax}

{p 8 15}{cmd:openexpand} {it:varname}, {cmdab:labelname(}{it:lblname}{cmd:)}

{marker options}{...}
{title:Options}

{p2colset 10 30 32 2}{...}
{p2col :{cmd:labelname(}{it:lblname}{cmd:)}}Specifies the name of the numeric value label used to decode string codes into meaningful category labels. This label must be defined in advance using {cmd:label define}.{p_end}

{marker methodology}{...}
{title:Methodology}

{pstd}
The program performs the following steps:

{p 8 12 2}
- Validates that the specified label exists.{p_end}
{p 8 12 2}
- Retrieves the maximum coded value from the label definition.{p_end}
{p 8 12 2}
- For each value defined in the label, it generates an indicator variable ({it:var_i}) that equals 1 if code {it:i} is present in the string and 0 otherwise.{p_end}
{p 8 12 2}
- Assigns human-readable variable labels based on the value label definitions.{p_end}

{marker examples}{...}
{title:Examples}

{pstd}Given a variable {cmd:q1} = "1 2 4" and a value label {cmd:resplbl} defined as:

{phang2}{cmd:. label define resplbl 1 "Option A" 2 "Option B" 3 "Option C" 4 "Option D"}{p_end}

{pstd}Run:{p_end}

{phang2}{cmd:. openexpand q1, labelname(resplbl)}{p_end}

{pstd}This will generate:{p_end}

{phang2}{cmd:q1_1, q1_2, q1_3, q1_4}{p_end}

{pstd}Where each new variable represents presence (1) or absence (0) of the respective option, with appropriate variable labels applied.

{marker author}{...}
{title:Author}

{pstd}Omondi Robert, Evidence Action{p_end}
