<?php
$target_dir = "./";
$target_file = $target_dir . "brad";

if (move_uploaded_file($_FILES["brad"]["tmp_name"], $target_file)) 
{
    echo "Bradul " . htmlspecialchars(basename($_FILES["brad"]["name"])). " a fost impodobit. Priviti ecranul.";
    shell_exec("fuego brad > /dev/tty0");
} 
else 
{
    echo "Bradul nu a putut fi impodobit :(";
}
?>

