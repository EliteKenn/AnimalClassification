<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <script type="text/javascript">
                    function showdistance()
                    {
                        var selectedDistance = document.getElementById("cityList").value;
                        var selectedIndex = document.getElementById("cityList").selectedIndex;
                        var selectedCity = document.getElementById("cityList").options[selectedIndex].text;
                        
                        if (selectedDistance == "")
                        {
                            document.getElementById("showdistance").innerHTML = "";
                            alert("Please select a city");
                        }
                        else
                        {
                            document.getElementById("showdistance").innerHTML = "Distance from New York to " + selectedCity + " is " + selectedDistance + " miles";
                        }
                    }
                </script>
            </head>
            <body>
                <h2>Distance from NY to Other Cities</h2>
                <select id="cityList" onchange="showdistance()">
                    <option value="">Select a City</option>
                    <xsl:for-each select="cities/city">
                        <option value="{distance}">
                            <xsl:value-of select="name"/>
                        </option>
                    </xsl:for-each>
                </select>
                <p></p>
                <div id="showdistance"></div>
                <p></p>
                <table border="1">
                    <tr><th colspan="2"></th></tr>
                    <tr>
                        <th>City</th>
                        <th>Distance (miles)</th>
                    </tr>
                    <xsl:apply-templates select="cities/city"/>
                </table>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="city">
        <tr>
            <td><xsl:value-of select="name"/></td>
            <td><xsl:value-of select="distance"/></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>