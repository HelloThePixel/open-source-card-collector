extends Node


func FilterByTags(cards : Array[CharacterUIElement], tags : PackedStringArray, inclusive = false, include_name = false, exact = false) -> Array[CharacterUIElement]:
	#inclusive == if it includes 1 or more of the gags, otherwise it must include all tags
	var filteredCards : Array[CharacterUIElement] = []
	
	
	for card in cards:
		#print("lets look at card " + card.characterName)
		var tagAmount = 0
		for tag in tags:
			#print("compare to tag " + tag)
			var hasAsTag = false
			tag = tag.strip_edges(true, true)
			var index = 0
			if tag != "":
				while index < card.tags.size():
					#print("tag:" + card.tags[index] + ", reftag:" + tag)
					if card.tags[index].contains(tag) and !exact:
						#print("tags contains tag")
						tagAmount += 1
						index = card.tags.size()
						hasAsTag = true
					elif card.tags[index] == tag and exact:
						#print("tags are identical")
						tagAmount += 1
						index = card.tags.size()
						hasAsTag = true
					else:
						#print("no tag")
						index += 1
			elif !inclusive:
				tagAmount+= 1
			
			if !hasAsTag and include_name:
				if card.characterName.contains(tag):
					if exact and card.characterName == tag:
						tagAmount += 1
					elif !exact:
						tagAmount += 1
				elif card.characterCredits.contains(tag):
					if exact and card.characterCredits == tag:
						tagAmount += 1
					elif !exact:
						tagAmount += 1
		if tagAmount > 0:
			if inclusive:
				filteredCards.append(card)
			elif tagAmount >= tags.size():
				filteredCards.append(card)
	
	return filteredCards
