This resource of the leonardo application describes the report layout of a Markdown based order results report.
It's useful for understanding how order results are presented in a structured report format.
The report includes sections such as header, footer and body.
The layout is designed to be clear and easy to follow.

Expected report layout:

Header layout:

The header contains on the left side the patients details and some order information. Each item should be on a separate line:
- Order Filler Number
- Full name
- Birth date
- National number
- Gender
- Contact information (email, phone, mobile phone)
On the right side of the header, the report contains the ordering provider details. Each item should be on a separate line:
- Full name
- Hc Provider mnemonic
- Identifier (if available)

Footer layout:

The footer includes:
- Report generation date and time
- Laboratory contact information = "simpson.lab@example.com"
- Page number

Body layout:
The body of the report includes:
- A title with the order results report name = "Biochemistry Results"
- Create a table to display order results with the following columns:
- Observation property description
- Observation value
- Observation units
- Observation references range
- Observation abnormal flag (if applicable)
- Observation result status
- Observation date and time
Each observation is presented in a separate row within the table.

Output Format:
Return the output strictly in Markdown format, using correct syntax for all elements included.
Do not include any explanatory text outside the Markdown content.
