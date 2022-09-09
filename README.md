
# Overview
The "Maxstation" is a Game Boy clone. Seen below next to an real Game Boy Pocket.

![maxstation_gameboy_clone_gbpocket_compare](/images/maxstation_gameboy_clone_gbpocket_compare.jpg | width=300)

# Some observed characteristics
* Game Boy Pocket form factor
* DMG-like CPU
* Scrolls a "Loading..." logo on power-up instead of "Nintendo"
* Runs too fast (~19.2% faster), as some other clones do
* Screen has significant motion blur
* Appears to have trouble powering on if connected to another powered-on Game Boy via Link Port
* Cartridge slot does not line up well with the case 

There are markings on the cart slot ("GF Logo") which may link it to "Gang Feng" / "Kong Feng", the makers of the "GB Boy (Pocket)" and "GB Boy Colour" clones.

# Maxstation Boot ROM
With help from nitro2k I dumped the boot ROM (see [bootrom folder](/bootrom/) using the [clock glitch](https://blog.gg8.se/wordpress/2014/12/09/dumping-the-boot-rom-of-the-gameboy-clone-game-fighter/) method.

The boot ROM is largely identical to the [DMG one](https://gbdev.gg8.se/files/roms/bootroms/), with a couple differences:
* Loads the scrolling logo from the bootrom (itself) instead of from the cartridge header region
* Different logo data ("Loading...")
* NOPs over the logo and checksum failure lockup tests


# Pictures
![maxstation_gameboy_clone_boot_logo](/images/maxstation_gameboy_clone_boot_logo.png | width=300)

![maxstation_gameboy_clone_pcb_back_cpu_marking_22C309CH](/images/maxstation_gameboy_clone_pcb_back_cpu_marking_22C309CH.jpg | width=300)

![maxstation_gameboy_clone_shell_back](/images/maxstation_gameboy_clone_shell_back.jpg | width=300)

![maxstation_gameboy_clone_cart_slot_GF_logo](/images/maxstation_gameboy_clone_cart_slot_GF_logo.jpg | width=300)

![maxstation_gameboy_clone_pcb_front](/images/maxstation_gameboy_clone_pcb_front.jpg | width=300)

![maxstation_gameboy_clone_screen_back](/images/maxstation_gameboy_clone_screen_back.jpg | width=300)
