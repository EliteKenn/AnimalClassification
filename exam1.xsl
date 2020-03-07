<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:key name="duo" match="animal" use="."/>
    <xsl:template match="/">
        <html>
            <head></head>
            <body>
                <h2>Animal Classification</h2>
                <table border="1">
                    <tr><th colspan="3">1. The complete classification.</th></tr>
                    <tr>
                        <th>Type</th>
                        <th>Most Common Traits</th>
                        <th>Example</th>
                    </tr>
                    <xsl:apply-templates select="animals/type"/>
                </table>
                <p/>
                <hr/>
                 <table border="1">
                    <tr><th colspan="3">2.Sorted animal classification by Type, order ascending.</th></tr>
                    <tr>
                        <th>Type</th>
                        <th>Most Common Traits</th>
                        <th>Example</th>
                    </tr>
                    <xsl:for-each select="animals/type">
                        <xsl:sort select="." order="ascending"/>
                        <tr>
                            <td><xsl:value-of select="@name"/></td>
                            <td><xsl:value-of select="traits"/></td>
                            <td><xsl:apply-templates select="animal"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                <p/>
                <hr/>
                <table border="1">
                    <tr><th colspan="3">3. Example of warm-blooded animals.</th></tr>
                    <tr>
                        <th>Type</th>
                        <th>Most Common Traits</th>
                        <th>Example</th>
                    </tr>
                    <xsl:apply-templates select="animals/type[contains(traits, 'Endothermic')]"/>
                </table>
                <p/>
                <hr/>
                4. How many cold-blooded animals:
                <xsl:value-of select="count(animals/type[contains(traits, 'Cold-blooded')]/animal)"/>
                <p/>
                <hr/>
                5. Display any animal with duo classification: 
                <xsl:apply-templates select="animals"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="type">
        <tr>
            <td><xsl:value-of select="@name"/></td>
            <td><xsl:value-of select="traits"/></td>
            <td><xsl:apply-templates select="animal"/></td>
        </tr>
        
    </xsl:template>
    <xsl:template match="animals">
        <xsl:for-each select="type/animal[generate-id()=generate-id(key('duo', .)[1])]">
            <xsl:if test="count(key('duo', .)) >= 2">
                <xsl:value-of select="."/>,&#160;
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="animal">
        <xsl:value-of select="."/>
        <xsl:if test="position() != last()">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>