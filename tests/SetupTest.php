<?php

declare(strict_types=1);

namespace PayCryptoMe\Primitives\Tests;

use Composer\Autoload\ClassLoader;
use PHPUnit\Framework\TestCase;

final class SetupTest extends TestCase
{
    public function testLibraryNamespaceIsRegistered(): void
    {
        $loader = require dirname(__DIR__) . '/vendor/autoload.php';
        self::assertInstanceOf(ClassLoader::class, $loader);
        self::assertArrayHasKey('PayCryptoMe\\Primitives\\', $loader->getPrefixesPsr4());
    }
}
