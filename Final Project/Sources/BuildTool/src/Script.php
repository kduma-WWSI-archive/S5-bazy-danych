<?php
namespace App;

class Script
{
    /**
     * @var string
     */
    public $file;

    /**
     * @var string
     */
    public $name;

    /**
     * @var int
     */
    public $version;

    /**
     * @var string
     */
    public $up;

    /**
     * @var string
     */
    public $down;

    /**
     * Script constructor.
     *
     * @param string $file
     * @param int    $version
     * @param string $name
     * @param string $up
     * @param string $down
     */
    private function __construct(string $file, int $version, string $name, string $up, string $down)
    {
        $this->file = $file;
        $this->version = $version;
        $this->name = $name;
        $this->up = self::format($up);
        $this->down = self::format($down);
    }

    public static function make(string $file, int $version) : self
    {
        $contents = file_get_contents($file);
        [$up, $down] = explode("\n---~~~\n", $contents, 2);

        $name = str_replace('_', ' ', substr($file, strpos($file, '_')+1, -4));

        return new self($file, $version, $name, $up, $down);
    }

    private static function format(string $sql)
    {
        $statements = explode("\nGO;", $sql);
        $statements = array_map('trim', $statements);
        $statements = array_filter($statements);
        $statements = array_map(function ($statement) {
            return "        EXEC dbo.sp_executesql @statement = N'\n".str_replace('\'', '\'\'', '          '.implode("\n          ", explode("\n", $statement)))."\n        '";
        }, $statements);

        return implode("\n\n", $statements);
    }

    public function up()
    {
        $new_version = $this->version;
        $required_version = $this->version - 1;

        return <<<SQL
PRINT 'Wersja {$this->version}: ''{$this->name}'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = {$required_version})
      BEGIN
{$this->up}
    
        UPDATE db_status SET version = {$new_version} WHERE version = {$required_version};
        PRINT 'Wersja {$this->version}: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji {$new_version}';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < {$required_version})
          BEGIN
            RAISERROR ('Wersja {$this->version}: Baza danych jest w za niskiej wersji (wymagana jest wersja {$required_version}) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja {$this->version}: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja {$this->version}: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END
SQL;

    }

    public function down()
    {
        $new_version = $this->version - 1;
        $required_version = $this->version;


        return <<<SQL
PRINT 'Wersja {$this->version}: ''{$this->name}'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = {$required_version})
      BEGIN
{$this->down}
    
        UPDATE db_status SET version = {$new_version} WHERE version = {$required_version};
        PRINT 'Wersja {$this->version}: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji {$new_version}';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > {$required_version})
          BEGIN
            RAISERROR ('Wersja {$this->version}: Baza danych jest w za wysokiej wersji (wymagana jest wersja {$required_version}) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja {$this->version}: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja {$this->version}: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END
SQL;
    }
}