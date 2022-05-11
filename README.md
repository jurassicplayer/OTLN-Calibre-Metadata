# OTLN-Calibre-Metadata
Curated calibre metadata for OTLN, going through the suffering so you don't have to.

### Installation
**WARNING: This isn't strenuously tested or anything. Safest route is to use a new library. Otherwise use Calibre Library => Library Maintenance => Library Metadata Backup Status => Queue all books for backup. Backup your files some place safe. Make sure to read the instructions and follow them EXACTLY.**

These instructions will copy files from the ToSort folders to the target Calibre Library
- Make a new Calibre Library (folder called `Light Novels` within this example)
- Clone the OTLN-Calibre-Metadata project to somewhere permanent (preferably using git clone rather than downloading the .zip)
- Get a ROM manager (these instructions will use [RomVault](https://www.romvault.com/)) and extract it somewhere permanent
- Make a folder called `ToSort` in the RomVault folder (old versions will accumulate here)
- Copy/symlink the `OTLN-Calibre-Metadata/dist/<metadata_set>.dat` to the `ROMVault/DatRoot` folder and remove any pre-existing files
    - Currently there is only one metadata set (OTLN_metadata.dat with just epubs), but in the future I'll add pdf when I get to it.
    - Symlinks are basically "shortcuts" in Windows, though I don't know if Windows shortcuts will work.
- Execute RomVault and perform the following configurations:
    - On the menu bar, use `Add ToSort` and select the OTLN folder to add OTLN as a source path
    - Use `Add ToSort` again and select the `OTLN-Calibre-Metadata/metadata` folder as a source path
    - On the menu bar, open the `Settings => RomVault Settings`
        - Add the following filename rules in the large text input box:
            ```
            *.epub
            *.pdf
            *.opf
            *.jpg
            *.zip
            ```
        - Press OK
    - On the menu bar, open the `Settings => Directory Settings`
        - Set the `Dir Location` to your `Light Novels` Calibre Library folder
        - Set `Archive Type` to `File`
        - Add the following filename rule to the `Filenames not to remove from RomDir's`
            ```
            *.db
            *.jpg
            ```
        - Press the `Apply` button and then `Done`
    - Close and re-open RomVault (This step is just in case)
    - Click `Update DATs`, then `Scan ROMs`, then `Find Fixes`, then `Fix ROMs`
    - Wait for the fixing to be completed (button will change to `Close`)
- Open Calibre and switch to your new Calibre Library
    - Navigate to `Calibre Library => Library Maintenance => Restore database` and press OK
    - Select all of the imported light novels and then press `Edit metadata`
    - Select `Change cover => Set from e-book files` and press OK
- Theoretically you should now have the same setup as me.

### Updating
- Open up a terminal in the `OTLN-Calibre-Metadata` directory and get the latest changes with `git pull origin`
- If your `OTLN-Calibre-Metadata/dist/<metadata_set>.dat` is not OR can't be symlinked, copy the .dat to the `ROMVault/DatRoot` folder
- Open RomVault and perform the following actions:
    - Click `Update DATs`, then `Scan ROMs`, then `Find Fixes`, then `Fix ROMs`
    - Wait for the fixing to be completed (button will change to `Close`)

### FAQ
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
- When will X series get metadata?
    - Possibly never. It's slow, tedious, boring work with no help. I'm going in alphabetical order, so if anything you can be hopeful for earlier letters.
### Guidelines
- Metadata source preference when available: YenPress/YenOn/J-Novel Club/etc. > Kobo > GoodReads > Amazon
#### Book IDs
- In order of importance: ISBN, AmazonID, GoodReads
- All books should have an ISBN number, search in kobo if it's not readily available elsewhere.
#### Tags
- Remove all `Manga` tags 
- Add `Light Novel` and `Official Translation` tags
- Add `Seinen`, `Shounen`, `Shoujo`, `Josei`, `Shounen Ai`, `Shoujo Ai`, `Yuri`, and `Yaoi` tags if possible, refer to the FAQ for a vague description of each category
    - Check wikipedia/novelupdates/somewhere about the series and see if they list it
- Add `Completed` status to light novels that are completed series
- Add genre tags from metadata source and NovelUpdates to all books in the series (non-spoiler tags)
#### Titles
- Uniform title structure
- Remove any `Novel` or `Light Novel`
- Volumes should be denoted after the title as `<Title>, Vol. XX`
- Subtitles should be added after the volume `<Title>, Vol. XX: Subtitle`
- Series should be named the same as the title without extras `<Title>`
#### Authors/Artists/Publishers
- Include artist as an author when available.
#### Publishers
- Publishers should have both publisher and publishing imprint if available. Ex. Yen Press publishes light novels under Yen On, so Yen Press LNs should have `Yen Press (Yen On)` as the publisher.
- Publishing date should be the date that the English release became widely available (digital or hard copy).
- Digital Manga (publisher) has imprint names that are horrendous for this guideline, I'm open to ideas.
    - By horrendous, I mean DMG and DMP are `Digital Manga (Digital Manga Guild)` and `Digital Manga (Digital Manga Publishing)` respectively.
    - Juné, Lilyka, and Project-H are fine though.
#### Descriptions
- Try to keep consistent sources for descriptions.
- Use your brain. If Yen Press has the same description for multiple volumes, but GoodReads has a unique description, opt for the unique one unless it deviates too far from the other descriptions structure. (Ex. 86 vol.5 & vol.6)

### To-Do
- Make a script that move files from a fresh copy to the correct folders with the correct filenames (generate list from my list and use checksums to determine filepaths?)
- Provide a clean update path and directions for updating set
- Revisit series: Code Geass, Dance in the Vampire Bund, Death Note
    - These are older light novels with only OCR scans and some metadata may be incorrect.

### Current Progress (based on v18.4)
106/489 (21.68%) Series (#-E)
0/43 (0.0%) Yaoi Series