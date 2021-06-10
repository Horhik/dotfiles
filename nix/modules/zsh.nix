{config, pkgs, ...}:
{
  programs.zsh.promptInit = "";
  programs.zsh = { 
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
	  enable = true;
    #    	ohMyZsh = {
    #  	  	enable = true;
    #	    	plugins = ["git" "colorize" "colored-man-pages" "emoji" "rustup" "sudo" "zsh-syntax-highlighting" "zsh-autosuggestions" "zsh-completions"];
    #		  theme = "cloud";
    #      customPkgs = [
    #        pkgs.zsh-syntax-highlighting
    #        pkgs.zsh-autosuggestions
    #        pkgs.zsh-completions
    #      ];
    #	  };
  };

}
