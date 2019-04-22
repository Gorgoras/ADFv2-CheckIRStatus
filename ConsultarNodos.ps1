$SubscriptionName = ""
$ResourceGroupName = ""
$DataFactoryName = ""
$AzureSSISName = ""

Login-AzureRmAccount


$null = Select-AzureRmSubscription -SubscriptionName $SubscriptionName

$nombre = "Gateway01ADFv2-Produccion"

$nodos = (Get-AzureRmDataFactoryV2IntegrationRuntimeMetric -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $nombre).Nodes

$a = 1 
while($a -lt 1000){
    $a = $a +1
    $numero = 1
    $nodos | ForEach($_){
        $nombreNodo = $_.NodeName
        $estado = Get-AzureRmDataFactoryV2IntegrationRuntimeNode -DataFactoryName $DataFactoryName -ResourceGroupName $ResourceGroupName -IntegrationRuntimeName $nombre -Name $nombreNodo
        
        if($estado.Status -like "Online"){
            $host.UI.RawUI.ForegroundColor = "Green"
            Write-Output "Nodo $($numero) esta: $($estado.Status)."
            $host.UI.RawUI.ForegroundColor = "DarkYellow"
        }else{
            Write-Warning "Nodo $($numero) esta: $($estado.Status)."
        }
        $numero = $numero +1
    }
Write-Output ([Environment]::NewLine)

Start-Sleep -Seconds 1

}
