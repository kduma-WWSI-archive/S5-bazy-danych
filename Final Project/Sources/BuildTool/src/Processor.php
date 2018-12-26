<?php
namespace App;

use League\CLImate\CLImate;
use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;
use SplFileInfo;

class Processor
{
    /**
     * @var CLImate
     */
    private $cli;

    /**
     * @var string[]
     */
    private $files = [];

    /**
     * @var Script[]
     */
    private $scripts = [];

    /**
     * Processor constructor.
     *
     * @param CLImate $climate
     */
    public function __construct(CLImate $climate)
    {
        $this->cli = $climate;
    }

    /**
     * @param $path
     */
    public function crawl($path)
    {
        $rii = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($path));

        /** @var SplFileInfo $file */
        foreach ($rii as $file) {

            if ($file->isDir() || $file->getExtension() != 'sql'){
                continue;
            }

            $this->files[$file->getBasename()] = $file->getPathname();

        }

        ksort($this->files);
    }

    public function build()
    {
        $version = 1;
        foreach ($this->files as $file) {
            $this->scripts[$version] = Script::make($file, $version);
            $version++;
        }
    }

    public function export(string $up_path, string $down_path)
    {
        ksort($this->scripts);

        $script = file_get_contents(__DIR__.'/stubs/pre.sql.stub')."\n\n\n\n".file_get_contents(__DIR__.'/stubs/up.sql.stub');

        $script .= "\n\n\n\n\n\n\n\n\n";
        foreach ($this->scripts as $s) {
            $script .= $s->up();
            $script .= "\n\n\n\n\n\n\n\n\n";
        }

        file_put_contents($up_path, $script."\n\n\n\n".file_get_contents(__DIR__.'/stubs/post.sql.stub'));


        krsort($this->scripts);

        $script = file_get_contents(__DIR__.'/stubs/pre.sql.stub')."\n\n\n\n";

        foreach ($this->scripts as $s) {
            $script .= $s->down();
            $script .= "\n\n\n\n\n\n\n\n\n";
        }

        $script .= file_get_contents(__DIR__.'/stubs/down.sql.stub');

        file_put_contents($down_path, $script."\n\n\n\n".file_get_contents(__DIR__.'/stubs/post.sql.stub'));
    }
}