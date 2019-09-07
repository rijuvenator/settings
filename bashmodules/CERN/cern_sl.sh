#### CERN Aliases ####
# CMSENV is the "real" cmsenv
# cmsset gives access to scram and cmsrel
# crabenv gives access to crab
# voms initializes voms proxy
# scramb navigates to working CMSSW, compiles, and returns to current dir
# cmsenv now runs cmsenv + sets scramb automatically
alias CMSENV='eval `scramv1 runtime -sh`'
alias cmsset='source /cvmfs/cms.cern.ch/cmsset_default.sh'
alias crabenv='source /cvmfs/cms.cern.ch/crab3/crab.sh'
alias voms='voms-proxy-init -voms cms'
alias vomsc='voms; cp /tmp/x509up_u79337 ~/'
alias scramb='echo "No SCRAM environment set yet"'
alias cmsenv='eval `scramv1 runtime -sh`; alias scramb="pushd ${CMSSW_BASE}/src/; scram b -j8; popd"'

# EOS directories
export EOS="eos/cms/store/user/adasgupt"
export EOSROOT="root://eoscms//eos/cms/store/user/adasgupt"
export EOSSRM="srm://srm-eoscms.cern.ch//eos/cms/store/user/adasgupt"
export EOSC="eos/cms/store/user/cschnaib"

# Logon history
sed -i "1a $(printf "%-10s --- %s\n" ${HOSTNAME%%.*} "`date +"%b %d %Y, %T %Z"`")" ~/logons
sed -ni "1,101p" ~/logons
