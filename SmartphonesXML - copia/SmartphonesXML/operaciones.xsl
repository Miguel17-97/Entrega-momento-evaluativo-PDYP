<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:template match="/">
        <html>
            <head>
                <style>
                    table {
                    border-collapse: collapse;
                    width: 100%;
                    }

                    th, td {
                    text-align: left;
                    padding: 8px;
                    }

                    tr:nth-child(even) {
                    background-color: #f2f2f2;
                    }

                    th {
                    background-color: #4CAF50;
                    color: white;
                    }
                </style>
            </head>
            <body>
                <h2>Total de personas que optaron por cada marca de teléfono</h2>
                <table border="1">
                    <tr>
                        <th>Marca</th>
                        <th>Total</th>
                    </tr>
                    <tr>
                        <td>Samsung</td>
                        <td>
                            <xsl:value-of select="sum(/Smartphones/Estados/Samsung)"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Apple</td>
                        <td>
                            <xsl:value-of select="sum(/Smartphones/Estados/Apple)"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Xiaomi</td>
                        <td>
                            <xsl:value-of select="sum(/Smartphones/Estados/Xiaomi)"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Sin preferencias</td>
                        <td>
                            <xsl:value-of select="sum(/Smartphones/Estados/Sin_preferencias)"/>
                        </td>
                    </tr>
                </table> 
                
                        
                <h2>Distribución de preferencias por estado</h2>
                <table border="1">
                    <tr>
                        <th>Estado</th>
                        <th>Samsung</th>
                        <th>Apple</th>
                        <th>Xiaomi</th>
                        <th>Sin Preferencias</th>
                    </tr>
                    <xsl:for-each select="/Smartphones/Estados">
                        <tr>
                            <td>
                                <xsl:value-of select="@nombre"/>
                            </td>
                            <td>
                                <xsl:value-of select="Samsung"/>
                            </td>
                            <td>
                                <xsl:value-of select="Apple"/>
                            </td>
                            <td>
                                <xsl:value-of select="Xiaomi"/>
                            </td>
                            <td>
                                <xsl:value-of select="Sin_preferencias"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
              
              
                <h2>Porcentaje de preferencias por marca</h2>
                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                <canvas id="brandChart" width="400" height="200"></canvas>
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        var ctx = document.getElementById('brandChart').getContext('2d');
                        var brandChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: ['Samsung', 'Apple', 'Xiaomi'],
                                datasets: [{
                                    label: 'Porcentaje de Preferencias',
                                    data: [
                                        <xsl:value-of select="format-number((sum(/Smartphones/Estados/Samsung) div sum(/Smartphones/Estados/Inscritos)) * 100, '0.00')"/>,
                                        <xsl:value-of select="format-number((sum(/Smartphones/Estados/Apple) div sum(/Smartphones/Estados/Inscritos)) * 100, '0.00')"/>,
                                        <xsl:value-of select="format-number((sum(/Smartphones/Estados/Xiaomi) div sum(/Smartphones/Estados/Inscritos)) * 100, '0.00')"/>
                                    ],
                                    backgroundColor: [
                                        'rgba(54, 162, 235, 0.2)',
                                        'rgba(255, 99, 132, 0.2)',
                                        'rgba(75, 192, 192, 0.2)'
                                    ],
                                    borderColor: [
                                        'rgba(54, 162, 235, 1)',
                                        'rgba(255, 99, 132, 1)',
                                        'rgba(75, 192, 192, 1)'
                                    ],
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        title: {
                                            display: true,
                                            text: 'Porcentaje (%)'
                                        }
                                    }
                                },
                                plugins: {
                                    legend: {
                                        display: false
                                    }
                                }
                            }
                        });
                    });
                </script>
                <h2>Porcentaje de personas inscritas por estado</h2>

                <!-- Gráfico de diagrama circular -->
                <canvas id="stateChart" width="200" height="200"></canvas>
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        var ctx = document.getElementById('stateChart').getContext('2d');
                        var stateChart = new Chart(ctx, {
                            type: 'doughnut',
                            data: {
                                labels: [
                                    <xsl:for-each select="/Smartphones/Estados">
                                        '<xsl:value-of select="@nombre"/>',
                                    </xsl:for-each>
                                ],
                                datasets: [{
                                    label: 'Porcentaje de Inscritos por Estado',
                                    data: [
                                        <xsl:for-each select="/Smartphones/Estados">
                                            <xsl:value-of select="Inscritos div sum(/Smartphones/Estados/Inscritos) * 100"/>,
                                            <xsl:text>,</xsl:text>
                                        </xsl:for-each>
                                    ],
                                    backgroundColor: [
                                        'rgba(255, 99, 132, 0.2)',
                                        'rgba(54, 162, 235, 0.2)',
                                        'rgba(255, 206, 86, 0.2)',
                                        'rgba(75, 192, 192, 0.2)',
                                        'rgba(153, 102, 255, 0.2)'
                                    ],
                                    borderColor: [
                                        'rgba(255, 99, 132, 1)',
                                        'rgba(54, 162, 235, 1)',
                                        'rgba(255, 206, 86, 1)',
                                        'rgba(75, 192, 192, 1)',
                                        'rgba(153, 102, 255, 1)'
                                    ],
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                plugins: {
                                    legend: {
                                        position: 'right'
                                    }
                                }
                            }
                        });
                    });
                </script>              
            </body>
        </html>
    </xsl:template> 
</xsl:stylesheet>