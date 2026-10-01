<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================================
     XSL TRANSFORMATION STYLESHEET: campus.xsl
     PROJECT: CAMPUS CONNECT
     DESCRIPTION: Transforms campus.xml into a clean, official HTML report.
     ============================================================================ -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
        <head>
            <title>Campus Connect - Information Directory</title>
            <style>
                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background-color: #f4f6f9;
                    color: #1e293b;
                    margin: 0;
                    padding: 20px;
                }
                .container {
                    max-width: 1100px;
                    margin: 0 auto;
                    background: #ffffff;
                    padding: 30px;
                    border-radius: 12px;
                    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
                }
                h1 {
                    color: #1e3a8a;
                    border-bottom: 3px solid #3b82f6;
                    padding-bottom: 10px;
                    margin-top: 0;
                }
                h2 {
                    color: #1e40af;
                    margin-top: 30px;
                    border-left: 4px solid #2563eb;
                    padding-left: 10px;
                }
                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 15px;
                    background: #ffffff;
                }
                th, td {
                    padding: 12px 15px;
                    text-align: left;
                    border-bottom: 1px solid #e2e8f0;
                }
                th {
                    background-color: #1e3a8a;
                    color: #ffffff;
                    font-weight: 600;
                    text-transform: uppercase;
                    font-size: 0.85rem;
                    letter-spacing: 0.5px;
                }
                tr:hover {
                    background-color: #f1f5f9;
                }
                .badge {
                    display: inline-block;
                    padding: 4px 8px;
                    border-radius: 4px;
                    font-size: 0.8rem;
                    font-weight: bold;
                    background-color: #e0e7ff;
                    color: #3730a3;
                }
                .college-info {
                    background: #eff6ff;
                    padding: 15px 20px;
                    border-radius: 8px;
                    border: 1px solid #bfdbfe;
                    margin-bottom: 25px;
                }
            </style>
        </head>
        <body>
            <div class="container">
                <h1><xsl:value-of select="campus/college/name"/></h1>
                <div class="college-info">
                    <p><strong>College Code:</strong> <xsl:value-of select="campus/college/code"/></p>
                    <p><strong>Address:</strong> <xsl:value-of select="campus/college/address"/></p>
                    <p><strong>Website:</strong> <a href="{campus/college/website}"><xsl:value-of select="campus/college/website"/></a></p>
                </div>

                <h2>Academic Departments</h2>
                <table>
                    <tr>
                        <th>Code</th>
                        <th>Department Name</th>
                        <th>Head of Department</th>
                        <th>Location</th>
                        <th>Contact Email</th>
                        <th>Students</th>
                    </tr>
                    <xsl:for-each select="campus/departments/department">
                        <tr>
                            <td><span class="badge"><xsl:value-of select="deptCode"/></span></td>
                            <td><strong><xsl:value-of select="deptName"/></strong></td>
                            <td><xsl:value-of select="hod"/></td>
                            <td><xsl:value-of select="location"/></td>
                            <td><xsl:value-of select="email"/></td>
                            <td><xsl:value-of select="totalStudents"/></td>
                        </tr>
                    </xsl:for-each>
                </table>

                <h2>Campus Facilities &amp; Labs</h2>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Facility Name</th>
                        <th>Category</th>
                        <th>Building / Location</th>
                        <th>Timings</th>
                        <th>Description</th>
                    </tr>
                    <xsl:for-each select="campus/facilities/facility">
                        <tr>
                            <td><xsl:value-of select="facId"/></td>
                            <td><strong><xsl:value-of select="facName"/></strong></td>
                            <td><span class="badge"><xsl:value-of select="category"/></span></td>
                            <td><xsl:value-of select="building"/></td>
                            <td><xsl:value-of select="timing"/></td>
                            <td><xsl:value-of select="description"/></td>
                        </tr>
                    </xsl:for-each>
                </table>

                <h2>Important Administrative Contacts</h2>
                <table>
                    <tr>
                        <th>Office / Cell</th>
                        <th>Designation</th>
                        <th>Contact Officer</th>
                        <th>Phone</th>
                        <th>Email</th>
                    </tr>
                    <xsl:for-each select="campus/contacts/contact">
                        <tr>
                            <td><strong><xsl:value-of select="office"/></strong></td>
                            <td><xsl:value-of select="designation"/></td>
                            <td><xsl:value-of select="personName"/></td>
                            <td><xsl:value-of select="phone"/></td>
                            <td><xsl:value-of select="email"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </div>
        </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
