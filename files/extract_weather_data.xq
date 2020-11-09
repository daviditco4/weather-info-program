<results>{
if ( doc("../output/data.xml")//ClientError )
then
	for $a in doc("../output/data.xml")//message/text()
	return
		<error>{
			if( $a = "no results") then ("No results were found near those coordintates")
			else if($a="wrong longitude") then ("The longitude must be a number within -180 and 180")
			else if($a="wrong latitude") then ("The latitude must be a number within -90 and 90")
			else if($a="cnt from 1 to 50" or substring-after($a, ' ') = "is not a number") then ("The number of cities must be an integer between 1 and 50")
			else $a
		}</error>
else
	for $a in distinct-values(doc("../output/data.xml")//country/text())
	let $b := doc("countries.xml")//country[@alpha-2 = $a]
	order by $b/@name
	return
		<country alpha-2="{$b/@alpha-2}">
			<name>{string($b/@name)}</name>
			<cities>{
				for $item in doc("../output/data.xml")//item[./city/country/text() = $b/@alpha-2]
				return
					<city>
						<name>{string($item/city/@name)}</name>
						<temperature unit="{$item/temperature/@unit}">{number($item/temperature/@value)}</temperature>
						<feels_like unit="{$item/temperature/@unit}">{number($item/feels_like/@value)}</feels_like>
						<humidity unit="{$item/humidity/@unit}">{round(number($item/humidity/@value))}</humidity>
						<pressure unit="{$item/pressure/@unit}">{round(number($item/pressure/@value))}</pressure>
						<clouds>{string($item/clouds/@name)}</clouds>
						<weather icon="{$item/weather/@icon}">{string($item/weather/@value)}</weather>
					</city>
			}</cities>
		</country>
}</results>
