# STATA ADO  
# openexpand

**Version:** 1.0  
**Author:** Omondi Robert   
**Date:** 2025-05-08  

---

## 📦 Overview

`openexpand` is a custom Stata command (`.ado`) that expands a space-separated string variable (e.g., `"1 2 4"`) into a set of binary (dummy) variables. Each binary variable indicates whether a coded value appears in the original string.  

This is especially useful when dealing with **open-ended, multiple-choice survey questions** stored as space-separated numeric codes in string format, which Stata cannot label directly.

---

## 🔍 Description

In many surveys, respondents can select multiple answers to a question, and their selections are recorded as a space-separated string (e.g., `"1 4 5"`). These values often correspond to a numeric value label (e.g., `1 = Radio`, `4 = Newspaper`, etc.).

Because **Stata does not allow value labels on string variables**, this command uses a predefined numeric value label to decode and expand the string into a set of dummy variables.

Each generated variable:
- Has the format: `varname_code`
- Equals `1` if the code exists in the string, otherwise `0`
- Is labeled using the corresponding entry from the value label

---

## ⚙️ Parameters

The following option is required:

| Option | Description |
|--------|-------------|
| `labelname(lblname)` | The name of a **predefined numeric value label** to use for decoding values in the string. Must be created using `label define` before using this command. |

---

## 📐 Methodology

1. **Check that value label exists.**  
2. **Loop through all values in the label.**  
3. **For each value:**  
   - Search the string for its presence.  
   - Generate a dummy variable: `varname_code`  
   - Assign a descriptive variable label from the value label.

---

## ▶️ Usage Example

You have a variable `q1` containing:

```
"1 2 4"
```

And a value label:

```stata
label define resplbl 1 "Radio" 2 "TV" 3 "Internet" 4 "Newspaper"
```

Run the command:

```stata
openexpand q1, labelname(resplbl)
```

This generates:

- `q1_1` (1 if "1" is in q1)
- `q1_2` (1 if "2" is in q1)
- `q1_3` (1 if "3" is in q1)
- `q1_4` (1 if "4" is in q1)

Each with proper variable labels like `"Radio"`, `"TV"`, etc.

---

## 📌 Notes

- Your string variable must contain numeric codes separated by spaces.
- Works well for coded open-ended survey responses.
- Pre-define your value label using `label define` before use.
- Does not apply value labels to the original string variable — instead, it **maps codes to new labeled dummies**.

---
