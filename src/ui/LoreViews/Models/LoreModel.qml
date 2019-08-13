import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQml.Models 2.12
import QtQuick.Controls 2.12


ObjectModel {
    id: root
    property int parentWidth

    ColumnLayout {
        width: root.parentWidth
        Label {
            text: "chapter 1"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 25

            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.topMargin: 84
        }
        Label {
            text: "A past tinted with blood"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 25
            font.bold: true

            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 24
        }

        Image {
            source: "qrc:/assets/lore/lore_0.jpg"
            fillMode: Image.PreserveAspectFit

            sourceSize.width: parent.width
            Layout.fillWidth: true
            Layout.bottomMargin: 24
        }

        Label {
            text: "<b>Sixty years</b> before the breakthrough which brought the Champions of Ilvash to the Five, <b>the"
                + "lands floating above Icaion</b> were a radically different place: the <b>Somber Years</b> having just"
                + "ended and a period of truce ensued between the two great wars. But the political landscape"
                + "was greatly influenced  by these two epic wars: at this point in time there had emerged <b>two"
                + "states ruling the lands of Mysthea</b>.<br><br>"

                + "These <b>two states</b> were the forces which during the Somber Years conquered all other smaller states,"
                + "expanding their <b>dominion over all known land</b>. As they grew in power, the <b>Kingdom of Ahatils</b> "
                + "and the <b>Kitrean Empire</b>, remained on the brink of conflict.<br><br>"

                + "While skirmishes and various small battles still took place <b>at the border between the two"
                + "forces</b>, they persisted for the moment in a kind of truce while recovering from the previous"
                + "conflict, and preparing for the inevitable <b>great war between them to come</b>."
            font.pixelSize: 18

            textFormat: Text.RichText
            wrapMode: Text.Wrap

            horizontalAlignment: Text.AlignJustify
            Layout.fillWidth: true
            Layout.leftMargin: 26
            Layout.rightMargin: 26
        }
    }

    ColumnLayout {
        width: root.parentWidth
        Label {
            text: "chapter 2"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 25

            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.topMargin: 84
        }
        Label {
            text: "A new elite surfacing"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 25
            font.bold: true

            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 24
        }

        Image {
            source: "qrc:/assets/lore/lore_1.jpg"
            fillMode: Image.PreserveAspectFit

            Layout.fillWidth: true
            sourceSize.width: parent.width
            Layout.bottomMargin: 24
        }

        Label {
            text: "<b>King Retudran Ahatils</b> remained preoccupied with his <b>kingdom’s borders</b>, constantly devising "
                  + "ways to prevent or predict potential enemy attacks, while all at once <b>developing strategies "
                  + "and plans for expansion</b>. Being too occupied with the happenings and potential troubles at "
                  + "the front as he was, the King was <b>not interested in managing the lands he had already "
                  + "conquered</b>, viewing governance as a trivial and unimportant task to be delegated. <br><br>"
                  + "In the King’s heart, <b>he remained more conqueror than ruler</b>. Therefore, he was not often present in Ilvash, "
                  + "the kingdom’s capital, and was <b>even less interested</b> in the happenings of the <b>newly conquered provinces</b>.<br><br>"
                  + "Administration of the provinces was delegated to the <b>King’s trustworthy ex-military commanders</b> who"
                  + "had showed ability in the field."
            font.pixelSize: 18

            textFormat: Text.RichText
            wrapMode: Text.Wrap

            horizontalAlignment: Text.AlignJustify
            Layout.fillWidth: true
            Layout.bottomMargin: 24
            Layout.leftMargin: 26
            Layout.rightMargin: 26
        }

        Image {
            source: "qrc:/assets/lore/lore_2.jpg"
            fillMode: Image.PreserveAspectFit

            Layout.fillWidth: true
            sourceSize.width: parent.width
            Layout.bottomMargin: 24
        }

        Label {
            text: "As a reward for their services, the King  would <b>grant them a household "
                + "name</b>, and the power to manage and rule over certain provinces- granted that the <b>King himself would "
                + "retain true ownership of the lands</b>. But in time it became clear that the provinces were terribly unruly "
                + "and unlawful, and the King was interested neither in overseeing nor imposing his will or law. Therefore, "
                + "<b>each province became autonomous in its own decision making</b>. And moreover, each province developed to be "
                + "radically different from the next. <br><br>"

                + "The King trusted his men to a certain degree, but he also felt the need to establish some method to "
                + "ensure they would never play clever tricks on him. So, he established that <b>each province should act as "
                + "a watchdog of its neighbors</b>, reporting directly to him in the event of any unusual whispers of trouble."
            font.pixelSize: 18

            textFormat: Text.RichText
            wrapMode: Text.Wrap

            horizontalAlignment: Text.AlignJustify
            Layout.fillWidth: true
            Layout.leftMargin: 26
            Layout.rightMargin: 26
        }
    }

    ColumnLayout {
        width: root.parentWidth
        Label {
            text: "chapter 3"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 25

            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.topMargin: 84
        }
        Label {
            text: "The Region of Rykalad"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 25
            font.bold: true

            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 24
        }

        Image {
            source: "qrc:/assets/lore/lore_3.jpg"
            fillMode: Image.PreserveAspectFit

            sourceSize.width: parent.width
            Layout.fillWidth: true
            Layout.bottomMargin: 24
        }

        Label {
            text: "In the region of <b>Rykalad</b> there was once a <b>powerful and proud kingdom</b> that fought valiantly before"
                + "losing the war against Ahatils during the Somber Years.<br><br>"

                + "This <b>kingdom’s capital, the city of Kyradar</b>, was built over an <b>intensely powerful anomaly</b> which to "
                + "this day remains active deep below the city. This anomaly amplifies the way in which Qoam resonates, "
                + "<b>allowing the former citizens of the conquered city to develop peculiar abilities</b> such as the ability "
                + "to forge objects with rare properties. <br><br>"

                + "This kingdom’s heritage was uniquely shaped by the presence of such a strong power. The capital together "
                + "with its <b>six satellite provinces</b> was once a peaceful kingdom interested solely in scholarly pursuits and "
                + "the study of <b>Qoam manipulation</b>. Every province, being built around Kyradar, managed one aspect of the "
                + "Kingdom, defining the lives of the citizens and their daily activities."
            font.pixelSize: 18

            textFormat: Text.RichText
            wrapMode: Text.Wrap

            horizontalAlignment: Text.AlignJustify
            Layout.fillWidth: true
            Layout.leftMargin: 26
            Layout.rightMargin: 26
        }
    }

    ColumnLayout {
        width: root.parentWidth
        Label {
            text: "chapter 4"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 25

            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.topMargin: 84
        }
        Label {
            text: "The Siege of Kyradar"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 25
            font.bold: true

            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 24
        }

        Image {
            source: "qrc:/assets/lore/lore_4.jpg"
            fillMode: Image.PreserveAspectFit

            sourceSize.width: parent.width
            Layout.fillWidth: true
            Layout.bottomMargin: 24
        }

        Label {
            text: "When <b>King Athalis</b> reached the region of Rykalad, it became clear to him how dependent the city of <b>Kyradar "
                + "had become on its six provinces</b>. He henceforth decided that the best way to <b>siege the capital would be "
                + "to first overtake these satellite cities</b>. And after conquering them, he utilized their strategic positioning, "
                + "slowly making his way toward the capital. <br><br>"

                + "The king’s conquest was relentless, <b>wrecking the city with no regard for its very existence as he increased"
                + "his territory</b>. Each time he would gain a stronger foothold in the city, the inhabitants sheltered themselves"
                + "in the inner limits until the fateful day that there was no place left for them to retreat.<br><br>"

                + "In the process, <b>the city was reduced to ruins but the King continued on with his conquest</b>. He could restore"
                + "the city to its former glory after the war ended; there was no need to waste resources now. The war continued"
                + "on, and <b>Kyradar devolved into wild and uninhabited ruins</b> while the King’s men ruled the region from the"
                + "surrounding six cities. When the war finally ended, the King had nearly forgotten about Kyradar and forsook"
                + "the city where it lay in utter ruin.<br><br>"

                + "<b>Two Houses</b> were assigned to manage these lands: The <b>Volarees House</b> and the <b>Rorius House</b>, "
                + "each one with <b>three cities under their control</b>. "
            font.pixelSize: 18

            textFormat: Text.RichText
            wrapMode: Text.Wrap

            horizontalAlignment: Text.AlignJustify
            Layout.fillWidth: true
            Layout.leftMargin: 26
            Layout.rightMargin: 26
        }
    }

    ColumnLayout {
        width: root.parentWidth
        Label {
            text: "chapter 5"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 25

            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.topMargin: 84
        }
        Label {
            text: "Volfyirion Comes"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 25
            font.bold: true

            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 24
        }

        Image {
            source: "qrc:/assets/lore/lore_5.jpg"
            fillMode: Image.PreserveAspectFit

            sourceSize.width: parent.width
            Layout.fillWidth: true
            Layout.bottomMargin: 24
        }

        Label {
            text: "Life in these areas was not much different from life in other conquered lands, with the <b>two Houses</b> ruling"
                + "the lands and maintaining a <b>watchful eye over each other’s deeds</b>. This continued until the ominous day that"
                + "a <b>terrible beast never before seen</b> glided from the sky onto the ruins of <b>Kyradar</b>, likely "
                + "attracted by the anomaly and the power it emanated.<br><br>"

                +"The two Houses understood immediately that the beast- <b>an incredible and fearsome dragon-</b> was awesomely"
                +"powerful and most certainly empowered by the energy from the anomaly.<br><br>"

                +"The dragon <b>remained settled in the ruins</b> of that place while the two Houses cautiously sent scouts and"
                +"explorers in <b>attempts to comprehend the beast’s nature</b>.<br><br>"

                + "Those first encounters with the dragon were terrible: <b>many men lost their lives to these meetings</b>."
                + "But the two houses understood from these encounters that it might be possible "
                + "to use Qoam manipulation to have the dragon under their own control. With further encounters "
                + "and experiments, the Houses discovered they <b>could tame the beast</b>, and each House <b>rushed to do this</b>, "
                + "both wanting to reach the terrible beast before the other won its favor.<br><br>"

                + "The two Houses <b>clashed into war</b>, trying to stop the other from gaining control of the <b>dreadful Volfyirion</b>. "

            font.pixelSize: 18

            textFormat: Text.RichText
            wrapMode: Text.Wrap

            horizontalAlignment: Text.AlignJustify
            Layout.fillWidth: true
            Layout.leftMargin: 26
            Layout.rightMargin: 26
        }
    }

    ColumnLayout {
        width: root.parentWidth
        Label {
            text: "chapter 6"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 25

            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.topMargin: 84
        }
        Label {
            text: "Aftermath"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 25
            font.bold: true

            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 24
        }

        Image {
            source: "qrc:/assets/lore/lore_6.jpg"
            fillMode: Image.PreserveAspectFit

            sourceSize.width: parent.width
            Layout.fillWidth: true
            Layout.bottomMargin: 24
        }

        Label {
            text: "In the end, <b>Volarees won the war</b>, destroying the three cities under the control of the opposing House, forcing"
                + "them to give up all hope of taming the dragon Volfyirion.<br><br>"

                + "After obtaining control of Volfyirion, <b>Weldrint Volarees marched to Ilvash with his men and the dragon, showing "
                + "off his power and bringing new demands before the King</b>. He wanted to own the lands that he ruled over. He wanted "
                + "to live in and own part of the city capital from which he could rule the provinces. And he hoped to live off the "
                + "income generated by these lands.<br><br>"

                + "The King was both <b>afraid of retaliation</b> and at the same time saw <b>potential for using the dragon in his war</b>, and "
                + "thus decided to concede something of what Weldrint Volarees asked. The King had <b>already planned to regulate the "
                + "provinces</b>; he knew it had to be done as he was aware that the provinces could not go on as they were. And so <b>he "
                + "seized the opportunity to reform them</b>.<br><br>"

                + "He <b>refused to give true land ownership</b>, but instead gave the House exclusive and almost irrevocable (with an "
                + "exception for the case of high treason) rights to: <b>rule, build, and collect taxes</b> over those lands for an indefinite "
                + "amount of time. To balance Volarees’ new power, he gave the same gift to the ruling military of the other provinces, "
                + "<b>creating what would become a privileged class of nobility</b>: he would take a cut of all taxes and would not have to "
                + "actively manage the territories."

            font.pixelSize: 18

            textFormat: Text.RichText
            wrapMode: Text.Wrap

            horizontalAlignment: Text.AlignJustify
            Layout.fillWidth: true
            Layout.leftMargin: 26
            Layout.rightMargin: 26
        }
    }

    ColumnLayout {
        width: root.parentWidth
        Label {
            text: "chapter 7"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 25

            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.topMargin: 84
        }
        Label {
            text: "The formation of Guilds"
            font.capitalization: Font.AllUppercase
            font.pixelSize: 25
            font.bold: true

            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.bottomMargin: 24
        }

        Image {
            source: "qrc:/assets/lore/lore_7.jpg"
            fillMode: Image.PreserveAspectFit

            sourceSize.width: parent.width
            Layout.fillWidth: true
            Layout.bottomMargin: 24
        }

        Label {
            text: "Because of the need to <b>limit the power of this newly born elite</b>, the King decided to force them to <b>join one guild "
                + "which would dictate and regulate how they could act</b>. The King wanted to keep strict control so he decreed how they "
                + "should rule and what they could and could not do on their lands. The king’s gift of land control was designed to be "
                + "<b>a privilege</b> which came with many strings attached.<br><br>"

                + "Lastly, the King would also elect <b>Weldrint Volarees to lead the guild, renaming it in his name in his honor</b>. He "
                + "gifted the guild the <b>Garden of the Pure, one of Ilvash’s most ancient districts</b> so they could establish their "
                + "headquarters. <br><br>"

                + "In exchange, the Guild <b>would take care to rule the lands in subordination to the King’s rule</b> and will. They would be "
                + "sure to serve the King and always answer his call, <b>never denying him the dragon when asked</b>. This appeared to be a "
                + "cleverly designed mutually beneficial compromise: the King would have all the provinces administered as he wanted "
                + "and without risking a takeover, while the noblemen would live a privileged life that required little work.<br><br> "

                + "The King, being an intelligent and visionary man, <b>determined shortly after to codify and empower other guilds</b>, taking "
                + "care that Volarees would not be the only powerful force inside his kingdom."
            font.pixelSize: 18

            textFormat: Text.RichText
            wrapMode: Text.Wrap

            horizontalAlignment: Text.AlignJustify
            Layout.fillWidth: true
            Layout.bottomMargin: 60
            Layout.leftMargin: 26
            Layout.rightMargin: 26
        }
    }
}
