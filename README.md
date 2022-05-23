# OTLN-Calibre-Metadata
Curated calibre metadata for OTLN, going through the suffering so you don't have to.

## Installation
**WARNING: This isn't strenuously tested or anything. Safest route is to use a new library. Otherwise use Calibre Library => Library Maintenance => Library Metadata Backup Status => Queue all books for backup. Backup your files some place safe.**

These instructions will copy files from your designated OTLN folder and the metadata folder to the target Calibre Library. Updating LNs+metadata should be relatively painless (provided I update the .xml as regularly as OTLN releases), but fixes related to author/title will require manual intervention to delete the offending folders before restoring the calibre database.
- Make a new Calibre Library (folder called `Light Novels` within this example)
- Clone the OTLN-Calibre-Metadata project to somewhere permanent (preferably using git clone rather than downloading the .zip)
- Have any of the following options installed/setup on your system in order to use [SabreTools](https://github.com/SabreTools/SabreTools):
    - The dotnet-runtime and net3.1 framework
        - For archlinux:
            ```
            pacman -S dotnet-runtime
            curl -s https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
            chmod +x dotnet-install.sh
            sudo ./dotnet-install.sh --install-dir /usr/share/dotnet -channel 3.1
            ``` 
    - A compiled native binary of sabretools and required libraries placed in the `dist/sabretools` folder
        - I might put this up somewhere and then automate the download/extract.
- Run the install_update.sh script
    - Select the `Light Novels` Calibre Library folder
    - Select the `OTLN` source folder
    - Confirm the action and wait for the process to finish.
- Open Calibre and switch to your `Light Novels` Calibre Library folder
    - Select all of the imported light novels and then press `Edit metadata`
    - Select `Change cover => Set from e-book files`
    - (Optional) Enable `Compress Cover images` and reduce quality to 85 (reduce aggregate cover size by roughly 66.7%)
    - Press OK
- Theoretically you should now have the same setup as me.

## Updating
- Open up a terminal in the `OTLN-Calibre-Metadata` directory and get the latest changes with `git pull origin`
- Run the install_update.sh script
    - Confirm the action and wait for the process to finish (this will overwrite files in your `Light Novels` Calibre Library).
    - If there are ebook filepaths not in the `OTLN_metadata.xml`, the script will list these paths and prompt you to delete them.
        - These could be due to author or title changes that affected the filepath of the ebook and are currently not handled by the script so as to prevent accidentally deleting people's files if they didn't read the warning.
        - These could also be due to external additions to the library which could conflict with additions from updated metadata (calibre book id conflicts).
    - Remove the offending filepaths before confirming the action and wait for the process to finish.
- Open Calibre and switch to your `Light Novels` Calibre Library folder
    - Select all of the newly imported light novels and then press `Edit metadata`
    - Select `Change cover => Set from e-book files`
    - (Optional) Enable `Compress Cover images` and reduce quality to 85 (reduce aggregate cover size by roughly 66.7%)
    - Press OK

## FAQ
- Why does ROMVault show that my metadata.opf has changed even though I haven't updated anything?
    - Calibre is a great program that seems to randomly sort the identifiers (isbn, kobo, amazon, etc.) and likes to put it's version number into the file. It's safe to ignore any of those changes as long as you personally haven't added any new metadata (read/unread status, etc.)
- Why split the metadata into .opf files?
    - I wouldn't be able to distribute anything if I were to embed them, and keeping the unaltered original files is nice for validity checks.
- Why go through the effort?
    - Any tech-savvy person would tell you that backups are your lifeline when things go south. A lot of tech-savvy people also don't have regular backups. This is my backup so the time I invest in this doesn't vanish due to some accident.
- What is OTLN?
    - It stands for "Officially Translated Light Novels".
- Why no subtitles as "Title" and the title as the series?
    - Not every series has subtitles, and though nice to have, `Under Pressure` doesn't really give an indication of what volume or series it's from.
- What is the difference between Shounen, Seinen, Shoujo, Josei, Shounen Ai, etc.?
    - They are more or less the target audience and provide a decent indication of what sorts of things are going to be in the light novel
        - Seinen: Mainly targeted towards an older demographic of men ages 18-45
        - Josei: Mainly targeted towards an older demographic of women ages 18-45
        - Shounen: Mainly targeted towards teenage boys below age 18
        - Shoujo: Mainly targeted towards teenage girls below age 18
        - Shounen Ai: Usually focuses on developing male/male relationships (not necessarily love, can be close friendships, but usually nothing physical)
        - Shoujo Ai: Usually focuses on developing female/female relationships (not necessarily love, can be close friendships, but usually nothing physical)
        - Yaoi (Boy's Love): Focuses on male/male relationships, usually the physical kind
        - Yuri (Girl's Love): Focuses on female/female relationships, usually the physical kind
- Why is the metadata of X light novel incorrect?
    - It's slow, tedious, and boring work with no help. If it's wrong, I probably missed it or made a mistake. Please make a github issue and I'll double-check/correct any issues.
- When will X series get metadata?
    - It's slow, tedious, and boring work with no help. I'm going in alphabetical order by folder, so if anything you can be hopeful for earlier letters.
## Metadata Guidelines
- Metadata source preference when available: YenPress/YenOn/J-Novel Club/etc. > Kobo > GoodReads > Amazon
### Book IDs
- In order of importance: ISBN, AmazonID, GoodReads
- All books should have an ISBN number, search in kobo if it's not readily available elsewhere.
### Tags
- Remove all `Manga` tags 
- Add `Light Novel` and `Official Translation` tags
- Add `Seinen`, `Shounen`, `Shoujo`, `Josei`, `Shounen Ai`, `Shoujo Ai`, `Yuri`, and `Yaoi` tags if possible, refer to the FAQ for a vague description of each category
    - Check wikipedia/novelupdates/somewhere about the series and see if they list it
- Add `Completed` status to light novels that are completed series
- Add genre tags from metadata source and NovelUpdates to all books in the series (non-spoiler tags)
### Titles
- Uniform title structure
- Remove any `Novel` or `Light Novel`
- Volumes should be denoted after the title as `<Title>, Vol. XX`
- Subtitles should be added after the volume `<Title>, Vol. XX: Subtitle`
- Series should be named the same as the title without extras `<Title>`
### Authors/Artists/Publishers
- Include artist as an author when available.
### Publishers
- Publishers should have both publisher and publishing imprint if available. Ex. Yen Press publishes light novels under Yen On, so Yen Press LNs should have `Yen Press (Yen On)` as the publisher.
- Publishing date should be the date that the English release became widely available (digital or hard copy).
- Digital Manga (publisher) has imprint names that are horrendous for this guideline, I'm open to ideas.
    - By horrendous, I mean DMG and DMP are `Digital Manga (Digital Manga Guild)` and `Digital Manga (Digital Manga Publishing)` respectively.
    - Juné, Lilyka, and Project-H are fine though.
### Descriptions
- Try to keep consistent sources for descriptions.
- Use your brain. If Yen Press has the same description for multiple volumes, but GoodReads has a unique description, opt for the unique one unless it deviates too far from the other descriptions structure. (Ex. 86 vol.5 & vol.6)

## To-Do
- Make a metadata clean-up script that deals with most simple issues (almost done)
- Make a script to generate the .dat file from the metadata and remove unimportant entries 
- Make an installation script that downloads RomVault cli to a folder, create ToSort, symlink dat, generate/modify RomVault3cfg.xml, prompt for OTLN folder and Calibre library folder, and run RomVault cycle
- Revisit series: Code Geass, Dance in the Vampire Bund, Death Note
    - These are older light novels with only OCR scans and some metadata may be incorrect.

## Current Progress (based on v18.4)
118/489 (24.13%) Series (#-F)
0/43 (0.0%) Yaoi Series