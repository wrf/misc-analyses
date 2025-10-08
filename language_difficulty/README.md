# What is the hardest language to learn? #
A commonly asked question, though it is really two sub-questions:

* what is the hardest *second* language to learn, starting from a given first language, let's say English?
* what is the hardest *native* language to learn, as in, what language do young children struggle the most to learn in their respective countries?

## What is the hardest second language to learn? ##
This question is conceptually simpler, as it seems to depend a lot on the first language. Related languages are sometimes mutually understood, such as Norwegian and Swedish, or Spanish and Italian. Thus, a speaker of Swedish would have a relatively easy time learning Norwegian, much more so than an Italian.

The [United States State Department Foreign Service Institute](https://www.state.gov/foreign-language-training/) categorizes some languages of the world by average time to learn for native English speakers. Based on the map below, these roughly take longer with more distance from the UK. 

![language_learning_difficulty_v1.png](https://github.com/wrf/misc-analyses/blob/master/language_difficulty/images/language_learning_difficulty_v1.png)

The FSI notes that "the actual time can vary based on a number of factors, including the language learner’s natural ability, prior linguistic experience, and time spent in the classroom." I suspect that the accuracy of the timing is not well calibrated for small countries. If there were 100 students of French and 5 students of Estonian, the institute probably has a much more accurate idea of the average time to learn French than of Estonian, which is probably why most of the languages of the world are in Category III (44 hours).

### Category I Languages: Languages more similar to English. 
| Category I Languages | 24-30 weeks | (600-750 class hours) |
| --- | --- | --- |
| Danish | Dutch | French (30 weeks) |
| Italian | Norwegian | Portuguese |
| Romanian | Spanish | Swedish |

### Category II Languages
| Category II Languages | Approximately 36 weeks | (900 class hours) |
| --- | --- | --- |
| German | Haitian Creole | Indonesian |
| Malay | Swahili |  |

### Category III Languages: Hard languages – Languages with significant linguistic and/or cultural differences from English. This list is not exhaustive. 
| Category III Languages | Approximately 44 weeks | (1100 class hours) |
| --- | --- | --- |
| Albanian | Amharic | Armenian |
| Azerbaijani | Bengali | Bulgarian |
| Burmese | Czech | Dari | 
| Estonian | Farsi | Finnish |
| Georgian | Greek | Hebrew |
| Hindi | Hungarian | Icelandic |
| Kazakh | Khmer | Kurdish |
| Kyrgyz | Lao | Latvian |
| Lithuanian | Macedonian | Mongolian |
| Nepali | Polish | Russian |
| Serbo-Croatian | Sinhala | Slovak |
| Slovenian | Somali | Tagalog |
| Tajiki | Tamil | Telugu | 
| Thai | Tibetan | Turkish |
| Turkmen | Ukrainian | Urdu |
| Uzbek | Vietnamese |  |

### Category IV Languages: Super-hard languages – Languages which are exceptionally difficult for native English speakers.
| Category IV Languages | 88 weeks | (2200 class hours) |
| --- | --- | --- |
| Arabic | Chinese – Cantonese | Chinese – Mandarin |
| Japanese | Korean | |


## What is the hardest native language to learn? ##
This is a more complicated question, as it relates to difficulties for children in learning their first language from their parents. That is, are there languages that are harder for children to natively acquire, or get to fluency?

The analyses below only deal with spoken language, though potentially parallels could be considered with different alphabets or writing systems. A study by [Bleses 2008](https://doi.org/10.1017/S0305000908008714) compiled results of studies measuring the pace that children learn to comprehend or speak their native language, across several European languages. The results are reproduced below. By most of the measures, [Danish](https://en.wikipedia.org/wiki/Danish_language) children learn to speak or understand the slowest. The authors highlight some [innate difficulties in the language](https://doi.org/10.1080/01690965.2010.515107), particularly difficulties in parsing words due to unpronounced consonants, resulting in long strings of vowel sounds.

![bleses_2008_fig1_data.png](https://github.com/wrf/misc-analyses/blob/master/language_difficulty/images/bleses_2008_fig1_data.png)

![bleses_2008_fig3_data.png](https://github.com/wrf/misc-analyses/blob/master/language_difficulty/images/bleses_2008_fig3_data.png)

![bleses_2008_fig4_data.png](https://github.com/wrf/misc-analyses/blob/master/language_difficulty/images/bleses_2008_fig4_data.png)

The authors note that between ages 2-3, much of this trend disappears, as children across most languages begin to acquire more extensive vocabulary at a similar pace. However, they do not propose a reason for the relatively high performance of [Croatian](https://en.wikipedia.org/wiki/Croatian_language) children.

![bleses_2008_fig7_data.png](https://github.com/wrf/misc-analyses/blob/master/language_difficulty/images/bleses_2008_fig7_data.png)

They also mention the systematically slower progression of children between UK English and US English. One reason for this may be differences in pronunciation between dialects, resulting in difficulties for British children. For example, the word "[water](https://en.wiktionary.org/wiki/water)" has different pronunciations in different English dialects, ranging from US /woter/, all letters pronounced, Australian or [UK RP](https://en.wikipedia.org/wiki/Received_Pronunciation) /wo:ta/, r dropped, or other UK /wo:?a/, t as a glottal stop, r dropped, sounding closer to two vowels in a row. Such words may be harder to parse at a young age.


## Increasing difficulty in learning kanji ##
For the [Kyouiku Kanji](https://en.wikipedia.org/wiki/Ky%C5%8Diku_kanji), the strokes per character increase on average with each school year. If this equates to difficulty in remembering the characters, then there is a rapid increase in difficulty. The most strokes per character in the first grade is 12, for [森 *mori* / forest](https://jisho.org/search/%E6%A3%AE%20%23kanji), while by 2nd grade, the max stroke count jumps to 18, for both [顔 *kao* / face](https://jisho.org/search/%E9%A1%94%20%23kanji) and [曜 *you* / weekday](https://jisho.org/search/%E6%9B%9C%20%23kanji).

![kanji_by_school_year_w_outliers.png](https://github.com/wrf/misc-analyses/blob/master/language_difficulty/images/kanji_by_school_year_w_outliers.png)

The *onyomi* may be especially difficult, as there is a high degree of convergence, ie. [homophones](https://en.wikipedia.org/wiki/Homophone), likely due to loss of [tonality](https://en.wikipedia.org/wiki/Tone_(linguistics)) for words imported from Chinese. Of the Kyouiku Kanji, many readings occur over ten times. Conversely, for the *kunyomi*, the most common reading is *kawa* with only 5 words.

### Most common onyomi readings ###
| onyomi (unique only) | number of characters | character list |
| ---    | --- | :--- |
| shi | 33 | 四 糸 矢 姉 市 紙 思 止 仕 使 始 指 歯 死 詩 史 司 士 氏 試 師 志 支 枝 示 資 飼 姿 私 至 視 詞 誌 |
| kou | 22 | 校 広 高 考 向 幸 港 候 功 好 康 航 効 厚 構 耕 講 鉱 孝 紅 鋼 降 |
| ki | 21 | 記 帰 汽 期 起 喜 器 季 希 旗 機 紀 基 寄 規 危 揮 机 貴 埼 崎 |
| shou | 19 | 小 少 勝 商 昭 消 章 唱 松 焼 照 笑 賞 承 招 証 傷 将 障 |
| kan | 16 | 寒 感 漢 館 完 官 管 観 関 刊 幹 慣 巻 干 看 簡 |
| ka | 16 | 花 火 夏 科 歌 何 化 荷 加 果 課 貨 価 可 河 過 |
| sou | 14 | 草 想 相 箱 送 争 倉 巣 総 創 奏 層 操 窓 |
| sen | 14 | 千 川 先 線 船 戦 浅 選 銭 宣 専 染 泉 洗 |
| sei | 14 | 星 声 晴 整 成 静 制 勢 政 精 製 盛 聖 誠 |
| shuu | 13 | 週 秋 州 拾 終 習 集 周 修 収 宗 就 衆 |
| kyuu | 13 | 休 弓 急 球 究 級 救 求 泣 給 久 旧 吸 |
| ken | 13 | 犬 県 研 健 建 験 件 券 検 険 憲 権 絹 |
| chou | 13 | 町 長 朝 鳥 丁 帳 調 兆 腸 張 庁 潮 頂 |
| shin | 12 | 森 親 心 新 深 申 真 身 進 信 臣 針 |
| tou  | 11 | 冬 当 島 投 湯 等 灯 統 党 糖 討 |
| kyou | 11 | 強 教 橋 共 協 競 鏡 境 興 胸 郷 |
| i | 11 | 医 委 意 以 位 囲 胃 衣 移 異 遺 |
| you | 10 | 曜 様 洋 羊 葉 陽 要 養 容 幼 |
| sai | 10 | 細 祭 最 菜 妻 採 災 際 済 裁 |
| kai | 10 | 海 回 界 開 階 改 械 快 届 灰 |
| hi | 10 | 悲 皮 費 飛 比 肥 非 否 批 秘 |


[Pinyin](https://en.wikipedia.org/wiki/Pinyin) are taken from [MDBG](https://www.mdbg.net/chinese/dictionary). For *sen*, there are common words that have different tones in Chinese, like [先生 *sensei* / teacher](https://jisho.org/word/%E5%85%88%E7%94%9F), but also [洗濯 *sentaku* / laundry](https://jisho.org/word/%E6%B4%97%E6%BF%AF). These are all merged into one reading in Japanese.

### Kanji with *sen* as the onyomi ###
| grade | number | Kanji | Strokes | Meaning | Onyomi | Kunyomi | Mandarin |
| ---:  | ---:   | ---   | ---:    | ---     | ---    | ---     | ---      |
| 1 | 12  | 千 | 3  | thousand | sen | chi  | qian1  |
| 1 | 27  | 川 | 3  | river    | sen | kawa | chuan1 |
| 1 | 56  | 先 | 6  | previous | sen | saki | xian1 |
| 2 | 98  | 線 | 15 | line     | sen | suji | xian4  |
| 2 | 223 | 船 | 11 | ship     | sen | fune | chuan2 |
| 4 | 524 | 戦 | 13 | war      | sen | ikusa, tataka-u | zhan4 |
| 4 | 562 | 浅 | 9  | shallow  | sen | asa-i | qian3  |
| 4 | 625 | 選 | 15 | choose   | sen | era-bu | xuan3  |
| 5 | 815 | 銭 | 14 | coin     | sen | zeni | qian2  |
| 6 | 867 | 宣 | 9  | proclaim | sen | notama-u | xuan1  |
| 6 | 870 | 専 | 9  | specialty | sen | moppa-ra | zhuan1 |
| 6 | 910 | 染 | 9  | dye      | sen | so-meru | ran3  |
| 6 | 919 | 泉 | 9  | fountain | sen | izumi | quan2  |
| 6 | 920 | 洗 | 9  | wash     | sen | ara-u | xi3  |

Likewise, for *shin*, some common words include [両親 *ryoushin* / parents](https://jisho.org/word/%E4%B8%A1%E8%A6%AA), [新聞 *shinbun* / newspaper](https://jisho.org/word/%E6%96%B0%E8%81%9E), [深海 *shinkai* / deep sea](https://jisho.org/word/%E6%B7%B1%E6%B5%B7), [心臓 *shinzou* / heart](https://jisho.org/word/%E5%BF%83%E8%87%93), and [神道 *shintou* / Shinto](https://jisho.org/word/%E7%A5%9E%E9%81%93).

### Kanji with *shin* as the onyomi ###
| grade | number | Kanji | Strokes | Meaning | Onyomi | Kunyomi | Mandarin |
| ---:  | ---:   | ---   | ---:    | ---     | ---    | ---     | ---      |
| 1 | 65 | 森 | 12 | forest | shin | mori | sen1  |
| 2 | 104 | 親 | 16 | parent | shin | oya | qin1  |
| 2 | 118 | 心 | 4 | heart | shin | kokoro | xin1  |
| 2 | 131 | 新 | 13 | new | shin | atara-shii | xin1  |
| 3 | 352 | 深 | 11 | deep | shin | fuka-i | shen1  |
| 3 | 362 | 申 | 5 | say | shin | mō-su | shen1  |
| 3 | 372 | 真 | 10 | true | shin | ma | zhen1  |
| 3 | 377 | 神 | 9 | deity | shin, jin | kami | shen2  |
| 3 | 412 | 身 | 7 | body | shin | mi | shen1  |
| 3 | 420 | 進 | 11 | progress | shin | susu-mu | jin4  |
| 4 | 452 | 信 | 9 | trust | shin |  | xin4  |
| 4 | 597 | 臣 | 7 | retainer | shin |  | chen2  |
| 6 | 995 | 針 | 10 | needle | shin | hari | zhen1  |



## learning numbers ##

Children learning regular number systems learn faster than irregular systems. ([Le 2020](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7721146))


## difficulties in learning to read ##
Variations in spelling ability appear to related to [orthographic depth](https://en.wikipedia.org/wiki/Orthographic_depth). This was systematically compared across 14 European countries by [Seymour et al 2003](https://pubmed.ncbi.nlm.nih.gov/12803812/). Other studies of Asian languages were added where there appeared to be a comparable test (though not exactly the same): [Pham 2020 - Vietnamese](https://pmc.ncbi.nlm.nih.gov/articles/PMC7963025/), [Winskel 2010 - Thai](https://link.springer.com/article/10.1007/s11145-009-9194-6)

![seymour2003_fig6_data-correct.png](https://github.com/wrf/misc-analyses/blob/master/language_difficulty/images/seymour2003_fig6_data-correct.png)

Clearly, English stands out in a bad way, due to a [known-to-be-awful orthography](https://en.wikipedia.org/wiki/English-language_spelling_reform). It might be the worst one in the world.

### candidate scheme for redefining English letters ###
English has a lot more vowels than letters (14 vs 5). [Danish/Swedish/Norwegian](https://en.wikipedia.org/wiki/Danish_and_Norwegian_alphabet) have an extra 3 vowel letters - Æ, Ø, and Å - which still would not be enough. The vowel reassignments were chosen to be those that would make sense to an adult English speaker. All 5 of the vowel-consonant-E sets moved the E to after the first vowel, so *date* would be *daet*. To me, this makes much more sense. A few others were very difficult:

Most European languages have *A* as /ɑ/, like in *father* or *park*, not /æ/ like *cat* and *hat*. A is kept as the short A, and *AA* becomes the spelling open A.

The double letter *OO* in English is another split: *good* vs. *food*. Here it is kept as /ʊ/ like *good*.

As T and D represent a pair of unvoiced and voiced sounds, TH and DH are kept for the same pair of [unvoiced](https://en.wikipedia.org/wiki/Voiceless_dental_fricative) and [voiced dental fricative](https://en.wikipedia.org/wiki/Voiced_dental_fricative) sounds. This would then change *breath* and *breathe* as *breth* and *breedh*.

Other letters, C, Q, X, are especially useless. These can be replaced by K/S, K, KS. 

In this case, *CH* is now always *C*, more similar to [Malay](https://en.wikipedia.org/wiki/Malay_orthography) or [Turkish](https://en.wikipedia.org/wiki/Turkish_alphabet). 

The letter *X* is now taking the *SH* sound in **all cases**, similar to [Chinese transliteration](https://en.wikipedia.org/wiki/Pinyin). This means that *fix* is now *fiks*, and *fish* is now *fix*. Most *-tion* endings would become *-xun*.

Most double-consonant combinations are removed, like all the *ff*, *gg*, *ll*, *mm*, *ss*, *tt* words, *stuf*, *huging*, *speling*, *stamer*, *clas*, *leter*. Awful clumps like [*OUGH*](https://en.wikipedia.org/wiki/Ough_(orthography)) are replaced by the actual vowels in American English, so would be *aalthoe* *ruflee* *thot* *thrue* *plau*.

| Letter      | Value      | Example (respelling)                             | Notes                            |
| ----------- | ---------- | ------------------------------------------------ | -------------------------------- |
| **A**       | /æ/        | *cat, hat → cat, hat*                            | Short *a*                        |
| **AA**      | /ɑ/        | *lot, hot, father → laat, haat, faather*         | Open back                        |
| **AE**      | /eɪ/       | *make, rain → maek, raen*                        | Long *a*                         |
| **AU**      | /aʊ/       | *house, down → haus, daun*                       | Diphthong                        |
| **B**       | /b/        | *bat → bat*                                      | Standard                         |
| **C**       | /tʃ/       | *church, each → curc, eec*                       | Repurposed for ch                |
| **D**       | /d/        | *dog → dog*                                      | Standard                         |
| **DH**      | /ð/        | *this → dhis*                                    | Voiced th                        |
| **E**       | /ɛ/        | *men → men*                                      | Short *e*                        |
| **EE**      | /iː/       | *meet, these → meet, dheez*                      | Long *ee*                        |
| **ER**      | /ɝ/        | *bird → berd*                                    | Stressed rhotic                  |
| **F**       | /f/        | *fish → fix* (since **x = sh**)                  | Standard                         |
| **G**       | /g/        | *go → goe*                                       | Always /g/                       |
| **H**       | /h/        | *hat → hat, hot → haat*                          | Standard                         |
| **I**       | /ɪ/        | *sit → sit*                                      | Short *i*                        |
| **IE**      | /aɪ/       | *time, my, I → tiem, mie, Ie*                    | Long *i*                         |
| **IR**      | /ɪr/       | *near → nir*                                     | Rhotic                           |
| **J**       | /dʒ/       | *jam → jam*                                      | Standard                         |
| **K**       | /k/        | *king → king*                                    | Always hard /k/                  |
| **L**       | /l/        | *lamp → lamp*                                    | Standard                         |
| **M**       | /m/        | *man → man*                                      | Standard                         |
| **N**       | /n/        | *net → net*                                      | Standard                         |
| **NG**      | /ŋ/        | *sing → sing*                                    | Digraph kept                     |
| **O**       | /ɔ/        | *law, thought, dog → lo, thot, dog*              | Distinct from aa                 |
| **OE**      | /oʊ/       | *note, go → noet, goe*                           | Long *o*                         |
| **OI**      | /ɔɪ/       | *boy → boi*                                      | Diphthong                        |
| **OO**      | /ʊ/        | *put, foot, book → poot, foot, book*             | Short oo                         |
| **P**       | /p/        | *pen → pen*                                      | Standard                         |
| **Q**       | (reserved) | *Qatar, Iraq → Qatar, Iraq*                      | For legacy/loanwords only        |
| **R**       | /r/        | *red → red*                                      | Standard                         |
| **S**       | /s/        | *see → see*                                      | Always /s/                       |
| **T**       | /t/        | *top → top*                                      | Standard                         |
| **TH**      | /θ/        | *thin → thin*                                    | Unvoiced th                      |
| **U**       | /ʌ/        | *cut, some, love → cut, sum, luv*                | Strut vowel                      |
| **UE**      | /uː/       | *flute, you, zoo, goose → fluet, yue, zue, gues* | Long *u*                         |
| **V**       | /v/        | *van → van*                                      | Standard                         |
| **W**       | /w/        | *we → wee*                                       | Standard                         |
| **X**       | /ʃ/        | *ship, shoe → xip, xue*                          | Repurposed for sh (pinyin style) |
| **Y**       | /j/        | *yes → yes, you → yue*                           | Always consonant y               |
| **Z**       | /z/        | *zoo → zue*                                      | Standard                         |
| **ZH**      | /ʒ/        | *measure, vision → mezhor, vizhon*               | Rare sound                       |

### Example text ###
This uses the above rules, with one exception, where the pronoun *I* is kept the same, just as the letter would be written, instead of the proposed phonetic *Ie*. The pronoun *you* potentially could be the same, converted to *u* instead of *yue*, which many people do in texting.

> "Kaal mee Ixmael. Sum yeerz agoe—nevor miend hau long presieslee—having litul or noe muni in mie pers, and nothing partikyueler tue interest mee on xor, I thot I wud sael abaut a litul and see dhe woteri part uv dhe werld. It iz a wae I hav uv drieving of dhe spleen and regyuelaeting dhe serkyuelaexun. Wenever I fiend mieself groeing grim abaut dhe mauth; wenever it iz a damp, drizlee November in mie soel; wenever I fiend mieself involontaerilee pauzing bifor kofin waerhauzez, and bringing up dhe reer uv evree fueneraal I meet; and espexalee wenever mie hiepoez get suc an uper hand uv mee, dhat it rekwierz a strong morol prinsipul tue prevent mee frum deliboretlee steping into dhe street, and methodiklee noking peepul’s hats of - dhen, I akaunt it hie tiem tue get tue see az suen az I kan."

> "Konfyuuxus (孔子; pinyin: Kongzi; lit. ‘Master Kong’; c. 551 – c. 479 BCE), born Kong Qiu (孔丘), wuz a Cieneez filosofer uv dhe Spring and Aatum pereeud hue iz tradixonalee konsiderd dhe paragon uv Cieneez saejez. Muc uv dhe xaerd kultuerul heritij uv dhe Sienosfeer orijinaets in dhe filosofee and teecings uv Konfyuuxus. Hiz filosofikul teecings, caald Konfyuuxunizm, emfasiezd personul and guvernmentul moralitee, haarmoeneeus soexal reelaexonxipz, rieceeusnes, kiendnes, sinseritee, and a rueler'z responsibiliteez tue leed bie vertue."









