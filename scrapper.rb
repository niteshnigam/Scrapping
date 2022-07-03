require 'httparty'
require 'nokogiri'
require 'byebug'

def scrapper
    url = "https://en.wikipedia.org/wiki/Lists_of_actors"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    result = Array.new

    nationalList =  parsed_page.css('div.mw-parser-output')
    linksDiv = nationalList.css('ul')[2]
    nationLinks = linksDiv.css('li>a')
    allLinks = Array.new
    
    puts ""

    rejectedKey = [ 
        "award", "festival", "production", "company", "critic", "score", "composer", "editor", "cinematographer", "animator", "screen", "writer", "producer", "director", "a-z", "zainichi", "cinema", "sageuk", "k-horror", "korean", "drama", "korea", "list", "actor", "studio", "animation", "culture", "template", "studio", "chungmuro"
    ]
    
    nationLinks.each do |links|
        if links.text.include? "pornographic"
            puts ""
            puts "EXCLUDED"
            puts ""
        elsif (links.text.downcase.include? "italian-american" or links.text.downcase.include? "native american")
            puts ""
            puts "EXCLUDED"
            puts ""
        elsif (links.text.downcase.include? "america" or links.text.downcase.include? "korea")
            countryArr = links.text.split(" ")
            countryName = countryArr[2, countryArr.length].join(" ")
            puts ""
            puts countryName
            puts ""

            flag = -1

            names = Array.new
            # puts "Names:"
            # puts names
            # puts ""
            linkUrl = "https://en.wikipedia.org"+links.attributes["href"].value
            link_unparsed_page = HTTParty.get(linkUrl)
            link_parsed_page = Nokogiri::HTML(link_unparsed_page)

            if linkUrl.include? "Category:"
                namesDiv = link_parsed_page.css("div.mw-category")
                namesLink = namesDiv.css('ul>li>a')
                namesLink.each do |tempLinks|
                    rejectedKey.each do |key|

                        # Conditions
                        # a tempLinks.attributes["href"]                                                true
                        # b tempLinks.text.downcase.include? "(actor"                                   true
                        # b tempLinks.text.downcase.include? "_actor)"                                  true
                        # c tempLinks.text.downcase.include? "(director"                                true
                        # c tempLinks.text.downcase.include? "_director)"                               true
                        # d tempLinks.attributes["href"].value.downcase.include? "(actor"               true
                        # d tempLinks.attributes["href"].value.downcase.include? "_actor)"              true
                        # e tempLinks.attributes["href"].value.downcase.include? "(director"            true
                        # e tempLinks.attributes["href"].value.downcase.include? "_director)"           true
                        # e tempLinks.attributes["href"].value.downcase.include? "korean_singer)"       true
                        # f tempLinks.text.downcase.include? key                                        false
                        # g tempLinks.attributes["href"].value.include? key                             false

                        if tempLinks.attributes["href"]
                            if tempLinks.text.downcase.include? key or tempLinks.attributes["href"].value.downcase.include? key
                                if tempLinks.text.downcase.include? "(actor" or tempLinks.text.downcase.include? "(director" or tempLinks.attributes["href"].value.downcase.include? "(actor" or tempLinks.attributes["href"].value.downcase.include? "(director" or tempLinks.text.downcase.include? "_actor)" or tempLinks.attributes["href"].value.downcase.include? "_actor)" or tempLinks.text.downcase.include? "_director)" or tempLinks.attributes["href"].value.downcase.include? "_director)" or tempLinks.attributes["href"].value.downcase.include? "korean_singer" 
                                    # puts key + " " + tempLinks.text + " " + tempLinks.attributes["href"].value + "------------------------------------ Allowed"
                                else
                                    flag = 1;
                                    puts key + " " + tempLinks.text + " " + tempLinks.attributes["href"].value + "------------------------------------ Not Allowed"
                                end
                            end
                        else
                            flag = 1
                        end
                    end
                    # puts " " + flag.to_s + " " + tempLinks.text + " " + tempLinks.attributes["href"].value
                    if flag != 1
                        profile_url = "https://en.wikipedia.org"+tempLinks.attributes["href"].value
                        profile_unparsed_page = HTTParty.get(profile_url)
                        profile_parsed_page = Nokogiri::HTML(profile_unparsed_page)

                        profileDiv = profile_parsed_page.css("table.infobox")
                        profileImg = profileDiv.css("img")
                        # puts ""
                        # puts profileImg
                        # puts ""
                        

                        if profileImg[0]
                            img = profileImg[0].attributes["src"]
                            puts ""
                            puts tempLinks.text
                            puts ""
                            obj = {
                                "name": tempLinks.text,
                                "imgUrl": "https:" + img.value,
                                "link": "https://en.wikipedia.org"+tempLinks.attributes["href"].value
                            }
                            names << obj
                        end
                        
                        # byebug
                    else
                        flag = -1
                    end
                end
            else
                namesDiv = link_parsed_page.css("div.div-col")
                namesLink = namesDiv.css('ul>li>a')
                namesLink.each do |tempLinks|
                    rejectedKey.each do |key|
                        
                        if tempLinks.attributes["href"]
                            if tempLinks.text.downcase.include? key or tempLinks.attributes["href"].value.downcase.include? key
                                if tempLinks.text.downcase.include? "(actor" or tempLinks.text.downcase.include? "(director" or tempLinks.attributes["href"].value.downcase.include? "(actor" or tempLinks.attributes["href"].value.downcase.include? "(director" or tempLinks.text.downcase.include? "_actor)" or tempLinks.attributes["href"].value.downcase.include? "_actor)" or tempLinks.text.downcase.include? "_director)" or tempLinks.attributes["href"].value.downcase.include? "_director)" or tempLinks.attributes["href"].value.downcase.include? "korean_singer" 
                                    # puts key + " " + tempLinks.text + " " + tempLinks.attributes["href"].value + "------------------------------------ Allowed"
                                else
                                    flag = 1;
                                    puts key + " " + tempLinks.text + " " + tempLinks.attributes["href"].value + "------------------------------------ Not Allowed"
                                end
                            end
                        else
                            flag = 1
                        end
                    end
                    # puts " " + flag.to_s + " " + tempLinks.text + " " + tempLinks.attributes["href"].value
                    if flag != 1
                        profile_url = "https://en.wikipedia.org"+tempLinks.attributes["href"].value
                        profile_unparsed_page = HTTParty.get(profile_url)
                        profile_parsed_page = Nokogiri::HTML(profile_unparsed_page)

                        profileDiv = profile_parsed_page.css("table.infobox")
                        profileImg = profileDiv.css("img")
                        # puts ""
                        # puts profileImg
                        # puts ""
                        

                        if profileImg[0]
                            img = profileImg[0].attributes["src"]
                            puts ""
                            puts tempLinks.text
                            puts ""
                            obj = {
                                "name": tempLinks.text,
                                "imgUrl": "https:" + img.value,
                                "link": "https://en.wikipedia.org"+tempLinks.attributes["href"].value
                            }
                            names << obj
                        end
                        # byebug
                    else
                        flag = -1
                    end
                    
                end
            end
            temp = {
                title: countryName,
                actors: names
            } 
            result << temp
            # byebug
        else
            # countryName = links.text.split(" ")[2]
            # puts ""
            # puts countryName

            # names = Array.new

            # linkUrl = "https://en.wikipedia.org"+links.attributes["href"].value
            # link_unparsed_page = HTTParty.get(linkUrl)
            # link_parsed_page = Nokogiri::HTML(link_unparsed_page)

            # if linkUrl.include? "Category:"
            #     namesDiv = link_parsed_page.css("div.mw-category")
            #     namesLink = namesDiv.css('ul>li>a')
            #     namesLink.each do |tempLinks|
            #         # puts tempLinks.text
            #         names << tempLinks.text
            #     end
            # else
            #     namesDiv = link_parsed_page.css("div.div-col")
            #     namesLink = namesDiv.css('ul>li>a')
            #     namesLink.each do |tempLinks|
            #         # puts tempLinks.text
            #         names << tempLinks.text
            #     end
            # end
            # temp = {
            #     country: countryName,
            #     actors: names
            # } 
            # result << temp
        end
        # byebug
        puts "-------------------------------------------------------------------------------------------------------------------------"
        puts ""
    end
    puts ""

    puts result
    req = HTTParty.post("http://localhost:5000/getData", 
        :body => { data: result }.to_json,
        :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'})
    
    puts req;

    # byebug
end

scrapper
