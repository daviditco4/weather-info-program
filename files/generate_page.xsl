<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <title>Weather Info</title>
                <link rel="stylesheet" href="../../files/style.css" type="text/css" />
            </head>

            <body>
                <xsl:choose>
                    <xsl:when test="count(//error)=0">
                        <h1>
                            Weather status on
                            <xsl:value-of select="count(//city)" />
                            cities around the world
                        </h1>
                        <xsl:for-each select="//country">
                            <h2>
                                Weather on
                                <xsl:value-of select="count(./cities/city)" />
                                cities of
                                <xsl:value-of select="./name" />
                            </h2>
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
                                        <td>
                                            <xsl:value-of select="name" />
                                        </td>
                                        <td>
                                            <xsl:call-template name="toCelsius">
                                                <xsl:with-param name="temp">
                                                    <xsl:value-of select="temperature" />
                                                </xsl:with-param>
                                                <xsl:with-param name="unit">
                                                    <xsl:value-of select="temperature/@unit" />
                                                </xsl:with-param>
                                            </xsl:call-template>
                                        </td>
                                        <td>
                                            <xsl:call-template name="toCelsius">
                                                <xsl:with-param name="temp">
                                                    <xsl:value-of select="feels_like" />
                                                </xsl:with-param>
                                                <xsl:with-param name="unit">
                                                    <xsl:value-of select="feels_like/@unit" />
                                                </xsl:with-param>
                                            </xsl:call-template>
                                        </td>
                                        <td>
                                            <xsl:value-of select="humidity" />
                                            <xsl:value-of select="humidity/@unit" />
                                        </td>
                                        <td>
                                            <xsl:value-of select="pressure" />
                                            &#160;
                                            <xsl:value-of select="pressure/@unit" />
                                        </td>
                                        <td>
                                            <xsl:value-of select="clouds" />
                                        </td>
                                        <td>
                                            <img class="weather_icon" alt="weather_icon">
                                                <xsl:attribute name="src">../../icons/<xsl:value-of select="./weather/@icon" />.png</xsl:attribute>
                                            </img>
                                            &#160;
                                            <xsl:value-of select="weather" />
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </table>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="//error">
                            <xsl:value-of select="." />
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="toCelsius">
        <xsl:param name="temp" />
        <xsl:param name="unit" />
        <xsl:choose>
            <xsl:when test="$unit='kelvin'">
                <xsl:value-of select="format-number(($temp)-273.15,'#0.##')" />
            </xsl:when>
            <xsl:when test="$unit='fahrenheit'">
                <xsl:value-of select="format-number((($temp)-32)*(5 div 9),'#0.##')" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$temp" />
            </xsl:otherwise>
        </xsl:choose>
        °C
    </xsl:template>
</xsl:transform>