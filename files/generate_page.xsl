<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <title>Weather on Citites</title>
                <link rel="stylesheet" href="../dummy/style.css"/>    <!-- href takes into account the generated .html file will be located on the output_files folder -->
            </head>

            <body>
                <h1>Weather on <xsl:value-of select="count(//city)"/> cities from <xsl:value-of select="count(//country)"/> countries</h1>
                <xsl:for-each select="//country">
                    <h2>Weather on <xsl:value-of select="count(./cities/city)"/> cities from <xsl:value-of select="./name"/></h2>
                    <table class="city-table">
                        <tr>
                            <th>City</th>
                            <th>Temperature</th>
                            <th>Feels Like</th>
                            <th>Humidity</th>
                            <th>Pressure</th>
                            <th>Clouds</th>
                            <th>Weather</th>
                        </tr>
                        <xsl:for-each select="./cities/city">
                            <tr>
                                <td><xsl:value-of select="name"/></td>
                                <td><xsl:value-of select="temperature"/>&#160;<xsl:value-of select="temperature/@unit"/></td> <!-- &#160; is the XML space (' ') character -->
                                <td><xsl:value-of select="feels_like"/>&#160;<xsl:value-of select="feels_like/@unit"/></td>
                                <td><xsl:value-of select="humidity"/><xsl:value-of select="humidity/@unit"/></td>
                                <td><xsl:value-of select="pressure"/>&#160;<xsl:value-of select="pressure/@unit"/></td>
                                <td><xsl:value-of select="clouds"/></td>
                                <td><xsl:value-of select="weather"/>&#160;<img class="weather_icon" alt="ERROR"><xsl:attribute name="src">../icons/<xsl:value-of select="./weather/@icon"/>.png</xsl:attribute></img></td>                            
                            </tr>
                        </xsl:for-each>
                    </table>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:transform>