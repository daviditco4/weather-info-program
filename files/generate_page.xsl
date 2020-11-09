<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <xsl:choose>
                <xsl:when test="count(//error)=0">
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
                                        <td>
                                            <xsl:variable name="tempValue" select="temperature"/>
                                            <xsl:choose>
                                                <xsl:when test="temperature/@unit='kelvin'">
                                                    <xsl:value-of select="format-number(($tempValue)-273.15,'#0.##')"/>
                                                </xsl:when>
                                                <xsl:when test="temperature/@unit='fahrenheit'">
                                                    <xsl:value-of select="format-number((($tempValue)-32)*(5 div 9),'#0.##')"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="$tempValue"/>
                                                </xsl:otherwise>      
                                            </xsl:choose>
                                        °C</td> <!-- &#160; is the XML space (' ') character -->
                                        <td>
                                            <xsl:variable name="feelsValue" select="feels_like"/>
                                            <xsl:choose>
                                                <xsl:when test="feels_like/@unit='kelvin'">
                                                    <xsl:value-of select="format-number(($feelsValue)-273.15,'#0.##')"/>
                                                </xsl:when>
                                                <xsl:when test="feels_like/@unit='fahrenheit'">
                                                    <xsl:value-of select="format-number((($feelsValue)-32)*(5 div 9),'#0.##')"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="$feelsValue"/>
                                                </xsl:otherwise>      
                                            </xsl:choose>
                                        °C</td>
                                        <td><xsl:value-of select="humidity"/><xsl:value-of select="humidity/@unit"/></td>
                                        <td><xsl:value-of select="pressure"/>&#160;<xsl:value-of select="pressure/@unit"/></td>
                                        <td><xsl:value-of select="clouds"/></td>
                                        <td><img class="weather_icon" alt="weather_icon"><xsl:attribute name="src">../icons/<xsl:value-of select="./weather/@icon"/>.png</xsl:attribute></img>
                                        &#160;<xsl:value-of select="weather"/></td>                           
                                    </tr>
                                </xsl:for-each>
                            </table>
                        </xsl:for-each>
                    </body>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:for-each select="//error">
                        <xsl:value-of select="./text()"/>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </html>
    </xsl:template>
</xsl:transform>