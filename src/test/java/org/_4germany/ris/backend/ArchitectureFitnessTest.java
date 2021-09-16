package org._4germany.ris.backend;

import static com.tngtech.archunit.library.dependencies.SlicesRuleDefinition.slices;

import com.tngtech.archunit.junit.AnalyzeClasses;
import com.tngtech.archunit.junit.ArchTest;
import com.tngtech.archunit.lang.ArchRule;

@AnalyzeClasses(packages = "org._4germany.ris.backend")
class ArchitectureFitnessTest {

  @ArchTest
  static final ArchRule preventPackageImportCycles =
      slices().matching("..backend.(*)..").should().beFreeOfCycles();
}
