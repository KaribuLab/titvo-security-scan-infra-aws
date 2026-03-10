# Rule: Validate and Format Terragrunt Code

Agents must validate and format Terragrunt configuration after modifying
infrastructure code.

This rule ensures that Terragrunt configuration remains valid and
consistently formatted.

------------------------------------------------------------------------

## Terragrunt Formatting

If the agent modifies any Terragrunt or Terraform configuration files
(such as `.hcl` files), it must format the code using Terragrunt's
built-in formatter.

Run:

    terragrunt hclfmt

Formatting must be applied immediately after making changes to `.hcl` or
Terragrunt configuration files.

------------------------------------------------------------------------

## Terragrunt Validation

After formatting, the agent must validate the full infrastructure
configuration.

Run:

    terragrunt run-all validate

If validation fails:

1.  identify the error
2.  fix the configuration
3.  rerun the validation

The agent must not continue work while the configuration is invalid.

------------------------------------------------------------------------

## Workflow Summary

When modifying Terragrunt or Terraform configuration:

1.  apply the code changes
2.  format the configuration using `terragrunt hclfmt`
3.  run `terragrunt run-all validate`
4.  fix issues if validation fails
