/// Wraps the context table + user question in the issue's own system-
/// instruction template (Issue #199 "Privacy-Safe Prompt Construction")
/// — instructs the SLM to answer only from local data and say "I don't
/// know" otherwise, rather than inventing figures.
class BuildAugmentedPrompt {
  static String call({required String contextTable, required String userQuery}) => '''
Use the following verified local data to answer. If the data is not present, say you don't know.

[LOCAL DATA CONTEXT]
$contextTable

[USER QUESTION]
$userQuery

Answer based ONLY on the data above. Use CAD currency.
'''
      .trim();
}
