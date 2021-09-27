package org._4germany.template;

import static com.tngtech.archunit.library.dependencies.SlicesRuleDefinition.slices;

import com.tngtech.archunit.junit.AnalyzeClasses;
import com.tngtech.archunit.junit.ArchTest;
import com.tngtech.archunit.lang.ArchRule;

@AnalyzeClasses(packages = "org._4germany.template")
class ArchitectureFitnessTest {

  @ArchTest
  static final ArchRule preventPackageImportCycles =
      slices().matching("..template.(*)..").should().beFreeOfCycles();
}
