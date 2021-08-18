
export const CreateAPIURL = (url: string, params: string = null): string => {
	return `https://chrissiddallapi.azure-api.net/${url}${((params)?`?${params}`:"")}`;
};