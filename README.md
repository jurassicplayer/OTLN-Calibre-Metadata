# OTLN-Calibre-Metadata
Curated calibre metadata for OTLN, going through the suffering so you don't have to.

### FAQ
- Why split the metadata into .opf files?
    - I wouldn't be able to distribute anything if I were to embed them, and keeping the unaltered original files is nice for validity checks.
- Why go through the effort?
    - Any tech-savvy person would tell you that backups are your lifeline when things go south. A lot of tech-savvy people also don't have regular backups. This is my backup so the time I invest in this doesn't vanish due to some accident.
- What is OTLN?
    - It stands for "Officially Translated Light Novels".
- Why no subtitles as "Title" and the title as the series?
    - Not every series has subtitles, and though nice to have, `Under Pressure` doesn't really give an indication of what volume or series it's from.

### Guidelines
- Metadata source preference when available: YenPress/YenOn/J-Novel Club/etc. > GoodReads > Amazon
#### Tags
- Remove all `Manga` tags 
- Add `Light Novel` and `Official Translation` tags
- Add genre tags from metadata source and NovelUpdates to all books in the series (non-spoiler tags)
#### Titles
- Uniform title structure
- Remove any `Novel` or `Light Novel`
- Volumes should be denoted after the title as `<Title>, Vol. XX`
- Subtitles should be added after the volume `<Title>, Vol. XX: Subtitle`
- Series should be named the same as the title without extras `<Title>`
#### Authors/Artists/Publishers
- Include artist as an author when available.
- Publishers should follow publishing imprint. Ex. Yen Press publishes light novels under Yen On, so Yen Press LNs should have Yen On as the publisher.
#### Descriptions
- Try to keep consistent sources for descriptions.
- Use your brain. If YenPress has the same description for multiple volumes, but GoodReads has a unique description, opt for the unique one unless it deviates too far from the other descriptions structure. (Ex. 86 vol.5 & vol.6)

### To-Do
- Make a script that move files from a fresh copy to the correct folders with the correct filenames (generate list from my list and use checksums to determine filepaths)
- Provide a clean update path and directions for updating set

### Current Progress (based on v15.1)
72/1792 (4.02%)