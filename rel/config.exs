use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: :dev

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"K@3&M5LgAB,%r[_Q)2Jt)U^0)1oNiT6Ot>0rzslDgngvYyfWEbg8[PvH@>iFI=Pr"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :">)<<m7_5szn;w:(N$^9jQ*&{<&e_BWSTntBF%hlL[j>ya(kO%a%ER0xukJb>Amt!"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :afy do
  set version: current_version(:afy)
end

