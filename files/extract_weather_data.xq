<results>{
for $a in distinct-values(doc("data/data.xml")//country/text())
let $b := doc("data/countries.xml")//country[@alpha-2 = $a]
order by $b/@name
return
	<country alpha-2="{$b/@alpha-2}">
		<name>{string($b/@name)}</name>
		<cities>{
			for $item in doc("data/data.xml")//item[./city/country/text() = $b/@alpha-2]
			return
				<city>
					<name>{string($item/city/@name)}</name>
					<temperature unit="{$item/temperature/@unit}">{number($item/temperature/@value)}</temperature>
					<feels_like unit="{$item/temperature/@unit}">{number($item/feels_like/@value)}</feels_like>
					<humidity unit="{$item/humidity/@unit}">{round(number($item/humidity/@value))}</humidity>
					<pressure unit="{$item/pressure/@unit}">{round(number($item/temperature/@value))}</pressure>
					<clouds>{string($item/clouds/@name)}</clouds>
					<weather icon="{$item/weather/@icon}">{string($item/weather/@value)}</weather>
				</city>
		}</cities>
	</country>
}</results>